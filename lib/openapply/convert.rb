require 'csv'

module Convert

  # assuming a single status (required) - this method returns a list csv
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

  # assuming a single status (required) - this method returns a list csv
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

  def students_hash_to_array(students, student_keys=[], guardian_info={}, payment_info={})
    array   = []
    array  << create_csv_headers( student_keys, guardian_info, payment_info )
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


  def process_key_info?(info)
    return true unless info.nil? or info.empty? or
                        info[:keys].nil? or info[:keys].empty?
    return false
  end

  def info_count(info)
    info[:count] || 1
  end

  def create_csv_headers( student_keys=[], guardian_info={}, payment_info={} )
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
end
