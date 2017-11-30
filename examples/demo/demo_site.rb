#!/usr/bin/env ruby

require 'httparty'
require 'openapply'

class MySite < Openapply::Client
  include HTTParty

  # Defines OpenApply domain name from ENV-VARS
  API_URL        = ENV['MY_API_BASE_URI']

  # Defines the OpenApply path from ENV-VARS - default is 5 seconds
  API_TIMEOUT    = (ENV['MY_API_TIMEOUT'].to_i || 5)

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
    ENV['MY_API_AUTH_TOKEN']
  end

  # Defines and makes visib le the OpenApply path with ENV-VARS
  def api_path
    ENV['MY_API_PATH'] || "/api/v1/students/"
  end

  # Defines and makes visible the maximum records OpenApply should return
  # (code default is 50 - OA default is 10 - doc says 100)
  def api_records
    ENV['MY_API_RECORDS'] || '50'
  end

  def initialize
    @my_flatten_keys = [:custom_fields]
    @my_reject_keys  = [:parent_guardian]
  end

  # defines remote host to recieve openapply data
  REMOTE_HOSTNAME    = ENV['REMOTE_HOSTNAME'].freeze
  REMOTE_USERNAME    = ENV['REMOTE_USERNAME'].freeze
  REMOTE_PATH_FILE   = ENV['REMOTE_PATH_FILE'].freeze
  REMOTE_PERMISSIONS = ENV['REMOTE_PERMISSIONS'].freeze

  # custom code to prepare my.openapply.com data for remote host recieving data
  def records_as_csv_to_file( status, flatten_keys=[],
                                reject_keys=[], student_keys=[],
                                guardian_info={}, payment_info={}, file )
    data = students_as_csv_by_status( status, flatten_keys, reject_keys,
                                student_keys, guardian_info, payment_info)
    # save csv string as a file
    open(file, 'w') { |f| f.puts data }
  end

  def records_as_csv_to_server( status, flatten_keys=[],
                                reject_keys=[], student_keys=[],
                                guardian_info={}, payment_info={})
    data = students_as_csv_by_status( status, flatten_keys, reject_keys,
                                student_keys, guardian_info, payment_info)
    send_data_to_remote_server( data, REMOTE_HOSTNAME, REMOTE_USERNAME,
                                "#{REMOTE_PATH_FILE}.csv", REMOTE_PERMISSIONS)
  end

  def records_as_xlsx_to_file( status, flatten_keys=[],
                                reject_keys=[], student_keys=[],
                                guardian_info={}, payment_info={}, file )
    data = students_as_xlsx_by_status( status, flatten_keys, reject_keys,
                                student_keys, guardian_info, payment_info)
    data.serialize(file)
  end

  def records_as_xlsx_to_server( status, flatten_keys=[],
                                reject_keys=[], student_keys=[],
                                guardian_info={}, payment_info={})
    data = students_as_xlsx_by_status( status, flatten_keys, reject_keys,
                                student_keys, guardian_info, payment_info)
    send_data_to_remote_server( data, REMOTE_HOSTNAME, REMOTE_USERNAME,
                                "#{REMOTE_PATH_FILE}.xlsx", REMOTE_PERMISSIONS)
  end

end
