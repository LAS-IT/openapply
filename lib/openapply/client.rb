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


    API_TIMEOUT = ENV['OA_TIMEOUT'].to_i || 5
    # Force RBENV var base_uri to https://
    API_URL     = case
                  when ENV['OA_BASE_URI'].start_with?('https://')
                    "#{ENV['OA_BASE_URI']}"
                  when ENV['OA_BASE_URI'].start_with?('http://')
                    "#{ENV['OA_BASE_URI']}".gsub("http", "https")
                  else
                    "https://#{ENV['OA_BASE_URI']}"
                  end

    base_uri API_URL
    default_timeout API_TIMEOUT

    # attr_reader :api_url, :api_key

    def initialize
      api_url     = API_URL
      api_key     = ENV['OA_AUTH_TOKEN']

      raise ArgumentError, 'OA_TIMEOUT is missing'    if api_timeout.nil? or
                                                          not api_timeout.is_a? Integer
      raise ArgumentError, 'OA_API_PATH is missing'   if api_path.nil? or
                                                          api_path.empty?
      raise ArgumentError, 'OA_BASE_URI is missing'   if api_url.nil? or
                                                          api_url.empty?
      raise ArgumentError, 'OA_AUTH_TOKEN is missing' if api_key.nil? or
                                                          api_key.empty?
    end

    def api_url
      API_URL
    end

    def api_timeout
      ENV['OA_TIMEOUT'].to_i
    end

    def api_key
      ENV['OA_AUTH_TOKEN']
    end

    def api_path
      ENV['OA_API_PATH']     || "/api/v1/students/"
    end

    def api_records
      ENV['OA_RECORD_COUNT'] || '50'
    end

    # @note Does the actual api call(get) to OpenApply & handles API timeouts gracefully
    # @param url [String] - this is the url to do the call
    # @param options - see httparty options [http://www.rubydoc.info/github/jnunemaker/httparty]

    def get(url, options={})
      # add exception if ENV are not set
      max_retries = 3
      times_retried = 0
      begin
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
      # add exception if ENV are not set
      # Per emai from Mackenzine on API call formatting, vs what is found on API site
     #  curl -X "PUT" "https://las.openapply.com/api/v1/students/OAID" \
     # -H 'Content-Type: application/x-www-form-urlencoded; charset=utf-8' \
     # --data-urlencode "student_id=YOURID" \
     # --data-urlencode "auth_token=YOURTOKEN"
      max_retries = 3
      times_retried = 0
      begin
        query = {auth_token: api_key}.merge(value)
        header = { 'Content-Type' => 'application/x-www-form-urlencoded; charset=utf-8' }
        self.class.put(url,
                        query: query,
                        headers: header )
        # self.class.put(url,
        #                 headers: header )
      rescue Net::ReadTimeout, Net::OpenTimeout
        if times_retried < max_retries
          times_retried += 1
          retry
        else
          { error: "no response (timeout) from URL: #{url}"  }
        end
      end
    end


    # @note checks the info for validity & unpacks the json retubed to a JS formatt
    # @note by passing in a value such as student_id or status this will automatically trigger the change form get to put
    # @param url [String] - this is the url to do the call
    # @param value [Hash] - This is used to update the student_id or status
    # @param options - see httparty options [http://www.rubydoc.info/github/jnunemaker/httparty]
    def oa_answer(url, value={}, options={})
      return { error: 'no url given' }        if url.nil? or url.to_s.eql? ""
      return { error: 'bad url - has space' } if url&.include? " "
      return { error: 'bad api_path' }    unless url&.include? "#{api_path}"
      if value.empty?
        return { error: 'bad auth_token' }  unless url&.include? "auth_token=#{api_key}"
        api_answer = send(:get, url, options)            if value.empty?
      else
        api_answer = send(:put, url, value, options) unless value.empty?
      end

      return api_answer               unless api_answer.respond_to? "response"
      return { error: 'no response' }     if api_answer.response.nil?
      return { error: 'no response' }     if api_answer.response.to_s.eql? ""
      return JSON.parse(api_answer.response.body, symbolize_names: true)
    end

  end

end
