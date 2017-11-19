require 'csv'
require 'axlsx'

module Convert

  # Queries by status to get a list of students details of a given status
  # and converts the result to an array with headers (based on keys sent)
  #
  # ==== Attributes
  # * +status+ - hash to convert to an array
  # * +flatten_keys+ - an array of keys to bring to the top level
  # (with this key prepened) -- default (blank does nothing)
  # * +reject_keys+ - an array of keys to remove from the data -- default (blank does nothing)
  # * +student_keys+ - [:id, :name] - include student record keys
  # * +guardian_info+ - include guardian record info {count: 2, keys: [:id, :name]}
  # * +payment_info+ - include payment info {count: 2, order: :newest, keys: [:date, :amount]}
  # * guardian & payment info options:
  #  count: 2 -- how many parent or payment records to return)
  #  keys: [:id, :date] -- an array of keys of data to return
  #  order: :newest -- the order to return payments :newest (most recent first - default) or :oldest
  def students_as_array_by_status(status,
                                  flatten_keys=[], reject_keys=[],
                                  student_keys=[],
                                  guardian_info={}, payment_info={})
    #
    students_hash   = students_details_by_status( status,
                                  flatten_keys, reject_keys)
    #
    students_array  = students_hash_to_array( students_hash,
                                  student_keys, guardian_info, payment_info)
  end
  alias_method :students_as_array_by_statuses, :students_as_array_by_status



  # CSV CODE
  ##########

  # Queries by status to get a list of students details of a given status
  # and converts the result to a CSV string with headers (based on keys sent)
  #
  # ==== Attributes
  # * +status+ - hash to convert to an array
  # * +flatten_keys+ - an array of keys to bring to the top level
  # (with this key prepened) -- default (blank does nothing)
  # * +reject_keys+ - an array of keys to remove from the data -- default (blank does nothing)
  # * +student_keys+ - [:id, :name] - include student record keys
  # * +guardian_info+ - include guardian record info {count: 2, keys: [:id, :name]}
  # * +payment_info+ - include payment info {count: 2, order: :newest, keys: [:date, :amount]}
  # * guardian & payment info options:
  #  count: 2 -- how many parent or payment records to return)
  #  keys: [:id, :date] -- an array of keys of data to return
  #  order: :newest -- the order to return payments :newest (most recent first - default) or :oldest
  def students_as_csv_by_status(  status,
                                  flatten_keys=[], reject_keys=[],
                                  student_keys=[],
                                  guardian_info={}, payment_info={})
    #
    students_array  = students_as_array_by_status(  status,
                                  flatten_keys, reject_keys,
                                  student_keys, guardian_info, payment_info )
    #
    student_csv_txt = students_array_to_csv( students_array )
  end
  alias_method :students_as_csv_by_statuses, :students_as_csv_by_status

  # Given an array convert to CSV string
  #
  # ==== Attributes
  # +array+ - expects a hash of students_details (should be flattened to use custom fields)
  def students_array_to_csv(array)
    return ""              if array.nil? or array.empty?
    # https://stackoverflow.com/questions/4822422/output-array-to-csv-in-ruby
    csv_string = CSV.generate do |csv|
      array.each do |row|
        csv << row
      end
    end
    return csv_string
  end


  # XLSX CODE
  ###########


  # Queries by status to get a list of students details of a given status
  # and converts the result to a XLSX Object (Axlsx::Package) with headers
  # (based on keys sent)
  #
  # ==== Attributes
  # * +status+ - hash to convert to an array
  # * +flatten_keys+ - an array of keys to bring to the top level
  # (with this key prepened) -- default (blank does nothing)
  # * +reject_keys+ - an array of keys to remove from the data -- default (blank does nothing)
  # * +student_keys+ - [:id, :name] - include student record keys
  # * +guardian_info+ - include guardian record info {count: 2, keys: [:id, :name]}
  # * +payment_info+ - include payment info {count: 2, order: :newest, keys: [:date, :amount]}
  # * guardian & payment info options:
  #  count: 2 -- how many parent or payment records to return)
  #  keys: [:id, :date] -- an array of keys of data to return
  #  order: :newest -- the order to return payments :newest (most recent first - default) or :oldest
  def students_as_xlsx_by_status( status,
                                  flatten_keys=[], reject_keys=[],
                                  student_keys=[],
                                  guardian_info={}, payment_info={})
    #
    students_array  = students_as_array_by_status(  status,
                                  flatten_keys, reject_keys,
                                  student_keys, guardian_info, payment_info )
    #
    students_xlsx    = students_array_to_xlsx( students_array )

    # example how to save the xlsx object as a file
    # students_xlsx.serialize("spec/data/xlsx/students_from_oa.xlsx")

    return students_xlsx
  end
  alias_method :students_as_xlsx_by_statuses, :students_as_xlsx_by_status


  # Given an array convert to XLSX Object (Axlsx::Package)
  #
  # ==== Attributes
  # +array+ - expects a hash of students_details (should be flattened to use custom fields)
  def students_array_to_xlsx(student_array)
    xlsx_obj = Axlsx::Package.new do |p|
      p.workbook.add_worksheet(:name => "Students from OpenApply") do |sheet|
        student_array.each{ |r| sheet.add_row r }
      end
      # to save the xlsx object as a file
      # p.serialize("spec/data/xlsx/students_from_oa.xlsx")
    end
    return xlsx_obj
  end


  # ARRAY CODE
  ############

  # Given an hash of students_details converts to an arrary
  #
  # ==== Attributes
  # * +students+ - hash to convert to an array
  # * +student_keys+ - [:id, :name] - include student record keys
  # * +guardian_info+ - include guardian record info {count: 2, keys: [:id, :name]}
  # * +payment_info+ - include payment info {count: 2, order: :newest, keys: [:date, :amount]}
  # * guardian & payment info options:
  #  count: 2 -- how many parent or payment records to return)
  #  keys: [:id, :date] -- an array of keys of data to return
  #  order: :newest -- the order to return payments :newest (most recent first - default) or :oldest
  def students_hash_to_array(students, student_keys=[], guardian_info={}, payment_info={})
    array   = []
    array  << create_headers( student_keys, guardian_info, payment_info )
    return array      if students.nil? or students.empty?

    students[:students].each do |student|
      row = []

      # next if student.nil? or student.empty? or
      #         student[:record].nil? or student[:record].empty?

      kid_record = student[:record]
      guardians  = student[:guardians]
      payments   = student[:payments]

      # inject student record info into the array
      student_keys.each{ |key| row << kid_record[key] }

      # inject guardian record info into the array
      if process_key_info?(guardian_info)
        count = info_count(guardian_info).to_i - 1
        # loop through the correct number of parents
        (0..count).each do |i|
          # add info if parent record exists
          guardian_info[:keys].each{ |key| row << guardians[i][key] } if guardians[i]
          # add nils if there isn't a parent record
          guardian_info[:keys].each{ |key| row << nil }           unless guardians[i]
        end
      end

      # inject guardian record info (most recent - last to oldest) into the array
      if process_key_info?(payment_info)
        if payment_info[:order].nil? or payment_info[:order].eql? :newest
          # get the newest records first
          count = info_count(payment_info).to_i
          # loop through the correct number of parents
          (1..count).each do |index|
            i = index * -1
            # puts "INDEX #{i}"
            payment_info[:keys].each{ |key| row << payments[i][key] } if payments[i]
            payment_info[:keys].each{ |key| row << nil }          unless payments[i]
          end
        else
          # start with the oldest records
          count = info_count(payment_info).to_i - 1
          # loop through the correct number of parents
          (0..count).each do |i|
            payment_info[:keys].each{ |key| row << payments[i][key] } if payments[i]
            payment_info[:keys].each{ |key| row << nil }          unless payments[i]
          end
        end
      end
      array << row
    end
    return array
  end

  # internal key to process given info or not
  def process_key_info?(info)
    return true unless info.nil? or info.empty? or
                        info[:keys].nil? or info[:keys].empty?
    return false
  end

  # determine count - may extend later to self-discover max number of records
  def info_count(info)
    info[:count] || 1
  end

  # Given the parameters passed in create the create csv / arrary headers
  #
  # ==== Attributes
  # * +students+ - hash to convert to an array
  # * +student_keys+ - include student record keys
  # * +guardian_info+ - include guardian record info {count: 2, keys: [:id, :name]}
  # * +payment_info+ - include payment info {count: 2, order: :newest, keys: [:date, :amount]}
  # * guardian & payment info options:
  #  count: 2 -- how many parent or payment records to return)
  #  keys: [:id, :date] -- an array of keys of data to return
  #  order: :newest -- the order to return payments :newest (most recent first - default) or :oldest
  def create_headers( student_keys=[], guardian_info={}, payment_info={} )
    headers  = []
    # figure out student headers
    headers  = ["student_id"]       if student_keys.nil? or student_keys.empty?
    headers  = student_keys.map{ |k| "student_" + k.to_s } unless student_keys.nil? or student_keys.empty?
    # figure out guardian headers
    if process_key_info?(guardian_info)
      guardian_count = info_count(guardian_info)
      # add the correct headers
      (1..guardian_count).each do |i|
        headers += guardian_info[:keys].map{|k| "guardian#{i}_" + k.to_s }
      end
    end
    # calculate payment headers
    if process_key_info?(payment_info)
      payment_count = info_count(payment_info)
      # add the correct headers
      (1..payment_count).each do |i|
        headers += payment_info[:keys].map{|k| "payment#{i}_" + k.to_s }
      end
    end
    return headers
  end

  # XFER CODE
  ###########

  # Send a string to convert to a file on a remote server
  # setup using ssh keys - not sure how to test - use at own risk
  #
  # === Attributes
  # * +data+ - object to be converted to a file on a remote system --
  # object can be a CSV String, Axlsx::Package or File object to be transfered
  # * +srv_hostname+ - fqdn or IP address of the remote host
  # * +srv_hostname+ - username to access the remote host
  # * +srv_path_file+ - full path and file name of the file on the remote host
  # * +file_permissions+ - permissions to make the file on the remote host (default is: 0750)
  def send_data_to_remote_server( data, srv_hostname, srv_username,
                                  srv_path_file, file_permissions='0750')
    # https://www.safaribooksonline.com/library/view/ruby-cookbook/0596523696/ch06s15.html
    # convert the string to a stringio object (which can act as a file)
    return "Unrecognized Object"  unless known_transfer_object?(data)
    # convert string into a SteamIO - "FILE" like object
    xfer = StringIO.new data          if data.is_a? String
    # convert Axlsx object into a SteamIO - "FILE" like object
    xfer = data.to_stream()           if data.is_a? Axlsx::Package

    # just move the file via SCP
    # xfer = data                       if data.is_a? File

    # http://www.rubydoc.info/github/delano/net-scp/Net/SCP
    # send the stringio object to the remote host via scp
    Net::SCP.start(srv_hostname, srv_username) do |scp|
      # asynchronous upload; call returns immediately
      channel = scp.upload( xfer, srv_path_file )
      channel.wait
    end
    # ensure file has desired permissions (via remote ssh command)
    Net::SSH.start(srv_hostname, srv_username) do |ssh|
      # Capture all stderr and stdout output from a remote process
      output = ssh.exec!("chmod #{file_permissions} #{srv_path_file}")
    end
  end
  alias_method :send_string_to_server_file, :send_data_to_remote_server

  def known_transfer_object?( object )
    return true  if data.is_a? String or data.is_a? Axlsx::Package or data.is_a? File
    return false
  end

end
