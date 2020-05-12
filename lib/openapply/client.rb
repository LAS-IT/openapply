require 'oauth2'
require "openapply/get_many_students"
require "openapply/get_one_student"
require "openapply/put"
require 'httparty'

module Openapply
  class Client

    include HTTParty                    # Library for API calls
    include Openapply::Put              # PUT api calls
    include Openapply::GetOneStudent    # GET api calls
    include Openapply::GetManyStudents  # GET api calls

    API_TIMEOUT = ENV['OA_TIMEOUT'].to_i
    API_TIMEOUT = 5 if ENV['OA_TIMEOUT'].to_i == 0
    default_timeout API_TIMEOUT

    def initialize(url: nil, client_id: nil, client_secret: nil, token: nil)
      @api_url     = format_api_url(url || ENV['OA_BASE_URI'])
      @api_client_id     = client_id || ENV['OA_CLIENT_ID']
      @api_client_secret     = client_secret || ENV['OA_CLIENT_SECRET']
      @api_key             = token || authentificate#.token

      raise ArgumentError, 'OA_BASE_URI is missing'   if api_url.nil? or
                                                          api_url.empty?
      raise ArgumentError, 'OA_CLIENT_ID is missing' if api_client_id.nil? or
                                                          api_client_id.empty?
      raise ArgumentError, 'OA_CLIENT_SECRET is missing' if api_client_secret.nil? or
                                                          api_client_secret.empty?

      self.class.base_uri api_url
    end

    def api_url
      @api_url
    end

    def api_timeout
      API_TIMEOUT
    end

    def api_client_id
      @api_client_id
    end

    def api_client_secret
      @api_client_secret
    end

    def api_key
      @api_key
    end

    def api_path
      "/api/v3"
    end

    def api_records
      ENV['OA_RECORD_COUNT'] || '100'
    end

    # @note Does the actual api call(get) to OpenApply & handles API timeouts gracefully
    # @param url [String] - this is the url to do the call
    # @param options - see httparty options [http://www.rubydoc.info/github/jnunemaker/httparty]

    def get(url, options={})
      max_retries = 3
      times_retried = 0
      begin
        options[:headers] = { 'Content-Type' => 'application/x-www-form-urlencoded; charset=utf-8', "Authorization" => auth_token}
        self.class.get(url, options)
      rescue Net::ReadTimeout, Net::OpenTimeout
        if times_retried < max_retries
          times_retried += 1
          retry
        else
          { error: "no response (timeout) from URL: #{url}"  }
        end
      end
    end
    alias_method :oa_api_call, :get

    # @note Does the actual api call(put) to OpenApply & handles API timeouts gracefully
    # @param url [String] - this is the url to do the call
    # @param options - see httparty options [http://www.rubydoc.info/github/jnunemaker/httparty]

    def put(url, value, options={})
      # Per emai from Mackenzine on API call formatting, vs what is found on API site
     #  curl -X "PUT" "https://las.openapply.com/api/v1/students/OAID" \
     # -H 'Content-Type: application/x-www-form-urlencoded; charset=utf-8' \
     # --data-urlencode "student_id=YOURID" \
     # --data-urlencode "auth_token=YOURTOKEN"
      max_retries = 3
      times_retried = 0
      begin
        options[:headers] = { 'Content-Type' => 'application/x-www-form-urlencoded; charset=utf-8', "Authorization" => auth_token}
        options[:body] = value
        self.class.put(url, options)
      rescue Net::ReadTimeout, Net::OpenTimeout
        if times_retried < max_retries
          times_retried += 1
          retry
        else
          { error: "no response (timeout) from URL: #{url}"  }
        end
      end
    end


    # @note checks the info for validity & unpacks the json retubed to a JS format
    # @note by passing in a value such as student_id or status this will automatically trigger the change form get to put
    # @param url [String] - this is the url to do the call
    # @param value [Hash] - This is used to update the student_id or status
    # @param options - see httparty options [http://www.rubydoc.info/github/jnunemaker/httparty]
    def oa_answer(url, value={}, options={})
      return { error: 'no url given' }        if url.nil? or url.to_s.eql? ""
      return { error: 'bad url - has space' } if url&.include? " "
      return { error: 'bad api_path' }    unless url&.include? "#{api_path}"
      if value.empty?
        api_answer = send(:get, url, options) if value.empty?
      else
        api_answer = send(:put, url, value, options) unless value.empty?
      end

      return api_answer               unless api_answer.respond_to? "response"
      return { error: 'no response' }     if api_answer.response.nil?
      return { error: 'no response' }     if api_answer.response.to_s.eql? ""
      return JSON.parse(api_answer.response.body, symbolize_names: true)
    end

    # @note authentificate using oauth2
    # @note returns OAuth2::AccessToken
    def authentificate
      client = OAuth2::Client.new(api_client_id, api_client_secret, site: api_url)
      return client.client_credentials.get_token
    end

    private

    def format_api_url(url)
      # Force RBENV var base_uri to https://
      return case
        when url.nil?
          raise ArgumentError, 'OA_BASE_URI is missing'
        when url.start_with?('https://')
          url
        when url.start_with?('http://')
          url.gsub("http", "https")
        else
          "https://#{url}"
        end
    end

    def auth_token
      "Bearer " + api_key
    end

  end

end
