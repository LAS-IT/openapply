#!/usr/bin/env ruby

require 'httparty'

class MySite < Openapply::Client
  include HTTParty

  # add customized site info
  # (say you need to use both: demo.openapply.com and my.openapply.com) --
  # this class defines my.openapply.com and its special needs
  localized_url = ENV['MY_BASE_URI']
  base_uri localized_url

  def api_key
    ENV['MY_AUTH_TOKEN']
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
