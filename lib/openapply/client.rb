
require "openapply/convert_to_xlsx"
require "openapply/convert_to_csv"
require "openapply/send_to_remote"
require "openapply/get_students"
require "openapply/get_student"
require "openapply/convert"
require "openapply/client"
require "openapply/put"
require 'httparty'

module Openapply

  # OpenApply CLIENT is a service to manage admissions -
  # this gem allows access to OpenApply API calls via HTTParty
  #
  class Client

    # PUT api calls
    include Put
    # GET api calls
    include Get
    # Convert student data to various formats
    include Convert
    # AXLSX files
    include ConvertToCsv
    # AXLSX files
    include ConvertToXlsx
    # Send To Remote ssh
    include SendToRemote

    # Library for API calls to OpenApply
    include HTTParty

    # Defines OpenApply domain name from ENV-VARS
    API_URL        = (ENV['OA_BASE_URI'] || 'demo.openapply.com')

    # Defines the OpenApply path from ENV-VARS - default is 5 seconds
    API_TIMEOUT    = (ENV['OA_TIMEOUT'].to_i || 5)

    base_uri API_URL
    default_timeout API_TIMEOUT

    # Makes OpenApply domain name visible:
    def api_url
      API_URL
    end

    # make OpenApply timeout visible
    def api_timeout
      API_TIMEOUT
    end

    # Defines & makes visible OpenApply secret access key with ENV-VARS
    def api_key
      ENV['OA_AUTH_TOKEN'] || 'demo_site_api_key'
    end

    # Defines and makes visib le the OpenApply path with ENV-VARS
    def api_path
      ENV['OA_API_PATH'] || "/api/v1/students/"
    end

    # Defines and makes visible the maximum records OpenApply should return
    # (code default is 50 - OA default is 10 - doc says 100)
    def api_records
      ENV['OA_REPLY_RECORDS'] || '50'
    end

    # Does the actual api call to OpenApply & handles API timeouts gracefully
    #
    # ==== Attributes
    # * +url+ - this is the url to do the call
    #  /api/v1/students/95?auth_token=demo_site_api_key
    # is the url passed when wanting to do the following cli api call
    #  curl http://demo.openapply.com/api/v1/students/95?auth_token=demo_site_api_key
    # * +options+ - see httparty options [http://www.rubydoc.info/github/jnunemaker/httparty]
    def oa_api_call(url, options={})
      # https://stackoverflow.com/questions/26251422/handling-netreadtimeout-error-in-httparty
      max_retries = 3
      times_retried = 0
      begin
        self.class.get(url, options)
      rescue Net::ReadTimeout, Net::OpenTimeout => error
        if times_retried < max_retries
          times_retried += 1
          # puts "TIMEOUT RETRY: #{times_retried} of #{max_retries} - USING: #{url.inspect}"
          retry
        else
          # puts "TIME-OUT URI FAILED: #{url.inspect}"
          { error: "no response (timeout) from URL: #{url}"  }
        end
      end
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

      api_answer = oa_api_call(url, options)

      return api_answer               unless api_answer.respond_to? "response" # and not api_answer[:error].nil?
      # return { error: 'no response' } unless api_answer.respond_to? "response"
      return { error: 'no response' }     if api_answer.response.nil?
      return { error: 'no response' }     if api_answer.response.to_s.eql? ""
      return JSON.parse(api_answer.response.body, symbolize_names: true)
    end
    # alias_method :openapply_answer, :oa_answer

  end  # Client

end    # Openapply
