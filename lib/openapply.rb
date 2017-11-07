require "openapply/get_students"
require "openapply/get_student"
require "openapply/version"
require "openapply/put"
require 'httparty'

module Openapply

  # OpenApply is a service to manage admissions -
  # this gem allows access to OpenApply API calls via HTTParty
  #
  class Client

    # Contains the GET api calls
    include Get
    # Contains the PUT api calls
    include Put
    # Library to make the API calls with OpenApply
    include HTTParty

    # Defines OpenApply domain name from ENV-VARS
    API_URL        = (ENV['OA_BASE_URI'] || 'demo.openapply.com')

    # Defines the OpenApply path from ENV-VARS - default is 5 seconds
    API_TIMEOUT    = (ENV['OA_TIMEOUT'].to_i || 5)

    base_uri API_URL
    default_timeout API_TIMEOUT

    # Defines OpenApply domain name from ENV-VARS - for example:
    #  demo.openapply.com
    def api_url
      API_URL
    end

    # Defines http timeout from ENV-VARS - 5 sec is the default
    def api_reply_count
      API_TIMEOUT
    end
    alias_method :api_timeout, :api_reply_count

    # Defines OpenApply secret access key with ENV-VARS
    def api_key
      ENV['OA_AUTH_TOKEN'] || 'demo_site_api_key'
    end

    # Defines the OpenApply path with ENV-VARS - default is for api_v1
    #  /api/v1/students/
    def api_path
      ENV['OA_API_PATH'] || "/api/v1/students/"
    end
    # alias_method :base_path, :api_path

    # Defines the maximum records OpenApply should return with each api call
    # with ENV-VARS - (code default is 100 - OpenApply default is 10)
    def api_records
      ENV['OA_REPLY_RECORDS'] || '100'
    end
    # alias_method :record_count, :api_max_records

    # Handles httparty timeout errors - tries 3x before quitting
    # https://stackoverflow.com/questions/26251422/handling-netreadtimeout-error-in-httparty
    # TODO: figure out how to test time outs
    def handle_timeouts
      max_retries = 3
      times_retried = 0
      begin
        yield
      rescue Net::ReadTimeout => error
        if times_retried < max_retries
          times_retried += 1
          # puts "TIMEOUT RETRY: #{times_retried} of #{max_retries} - USING: #{yield.inspect}"
          retry
        else
          # puts "TIME-OUT URI FAILED: #{yield.inspect}"
          { error: "SITE TIMEOUT - 3 FAILURES USING: #{yield.inspect}" }
        end
      end
    end

    # Does the actual api call to OpenApply
    #
    # ==== Attributes
    # * +url+ - this is the url to do the call
    #  /api/v1/students/95?auth_token=demo_site_api_key
    # is the url passed when wanting to do the following cli api call
    #  curl http://demo.openapply.com/api/v1/students/95?auth_token=demo_site_api_key
    # * +options+ - see httparty options [http://www.rubydoc.info/github/jnunemaker/httparty]
    def oa_api_call(url, options={})
      self.class.get(url, options)
    end

    # Does checks the info for validity & unpacks the json retubed to a JS formatt
    #
    # ==== Attributes
    # * +url+ - this is the url to do the call
    #  /api/v1/students/95?auth_token=demo_site_api_key
    # is the url passed when wanting to do the following cli api call
    #  curl http://demo.openapply.com/api/v1/students/95?auth_token=demo_site_api_key
    # * +options+ - see httparty options [http://www.rubydoc.info/github/jnunemaker/httparty]
    def oa_answer(url, options={})
      # puts
      # puts "GIVEN URL: #{ url.inspect }"
      return { error: 'no url given' }        if url.nil? or url.to_s.eql? ""
      return { error: 'bad url - has space' } if url.include? " "
      return { error: 'bad api_path' }    unless url.include? "#{api_path}"
      return { error: 'bad auth_token' }  unless url.include? "auth_token=#{api_key}"
      api_answer = nil

      handle_timeouts do
        api_answer = oa_api_call(url, options)
      end

      # puts "API ANSWER: #{api_answer}"
      # puts "API ANSWER: #{api_answer.inspect}"
      return { error: 'no response' } unless api_answer.respond_to? "response"
      return { error: 'no response' }     if api_answer.response.nil?
      return { error: 'no response' }     if api_answer.response.to_s.eql? ""
      return JSON.parse(api_answer.response.body, symbolize_names: true)
    end
    # alias_method :openapply_answer, :oa_answer

  end  # Client

end    # Openapply
