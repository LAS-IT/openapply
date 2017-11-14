module Get

  # Record details for ONE student - this API return has the parent info 2x!
  #
  # @param
  # ==== Attributes
  # * +student_id+ - openapply student_id
  # * +options+ - see httparty options
  #
  # ==== Example code
  #  @demo = Openapply.new
  #  @demo.student_by_id(96)
  def student_by_id(student_id, options ={})
    url = "#{api_path}#{student_id}?auth_token=#{api_key}"
    return oa_answer( url, options )
  end
  alias_method :student, :student_by_id


  # Payment details for ONE student
  #
  # ==== Attributes
  # * +student_id+ - openapply student_id
  # * +options+ - see httparty options
  #
  # ==== Example code
  #  @demo = Openapply.new
  #  @demo.payments_by_id(96)
  def payments_by_id(student_id, options={})
    url = "#{api_path}#{student_id}/payments?auth_token=#{api_key}"
    return oa_answer( url, options )
  end
  alias_method :payments, :payments_by_id


  # Combines the student_by_id & payments_by_id into one call with all the data
  #
  # ==== Attributes
  # * +student_id+ - openapply student_id
  # TODO: COMMENT BETTER SO IT IS UNDERSTANDABLE
  def student_details_by_id(id, flatten_keys=[],reject_keys=[])
    student_info = student_by_id( "#{id}" )
    payment_info = payments_by_id( "#{id}" )

    # be sure there is data to process
    return {student: {id: id, empty: []}}        if student_info.nil? or
                                                    student_info[:student].nil?
                                                    student_info[:student].empty?
    student = []
    guardians = []
    guardians = student_info[:linked][:parents].dup unless
                                                    student_info[:linked].nil? or
                                                    student_info[:linked].empty? or
                                                    student_info[:linked][:parents].nil?
    payments = []
    payments = payment_info[:payments].dup   unless payment_info.nil? or
                                                    payment_info[:payments].nil?
    # if no keys do nothing (except remove duplicate guardian info)
    if  (flatten_keys.nil? or flatten_keys.empty?) and
        (reject_keys.nil?  or reject_keys.empty?)
      # make a copy to avoid messing up the data
      student = student_info[:student].dup
      # remove duplicated parental data fields
      student[:custom_fields][:parent_guardian] = nil
    else
      flatten_keys = [:flatten_no_keys] if flatten_keys.nil? or flatten_keys.empty?
      reject_keys  = [:reject_no_keys]  if reject_keys.nil?  or reject_keys.empty?
      student = flatten_record(student_info[:student], flatten_keys, reject_keys)
      g_flat = []
      guardians = guardians.each do |guard|
        next                 if guard.empty?
        g_flat << flatten_record( guard, flatten_keys, reject_keys )
      end                unless guardians.empty?
      guardians = g_flat unless g_flat.empty?
    end

    return { student:
              { id: id,
                record: student,
                payments: payments,
                guardians: guardians,
              }
            }
  end
  alias_method :student_details, :student_details_by_id

  # return value & remove linebreaks & trim spaces (if a string)
  def clean_data( value )
    return value.gsub("\n",' ').strip   if value.is_a? String
    return value
  end

  # TODO: add recursion?
  # TODO: COMMENT BETTER SO IT IS UNDERSTANDABLE
  def flatten_record(hash, flatten_keys=[:flatten_no_keys],reject_keys=[:reject_no_keys])
    # Rails.logger.debug "Hash in: #{hash.inspect}"
    # Rails.logger.debug "Flatten Fields: #{flatten_field_keys.inspect}"
    answer = {}
    hash.each do |key,val|
      # SPECIAL KEY - BRING TO TOP LEVEL
      if flatten_keys.include? key
        # don't loop if empty field to flatten is empty
        next if val.empty?
        next if reject_keys.include? key

        # Bring data to top level
        # (prepend flatten_key_to_current_key - prevent conflicts)
        val.each do |k,v|
          next if reject_keys.include? k
          new_key = "#{key.to_s}_#{k.to_s}".to_sym
          value = clean_data(v)
          answer[new_key] = v
        end
      else
        next if reject_keys.include? key
        # STANDARD KEY - keep data as is - but remove linebreaks
        value = clean_data(val)
        answer[key] = value
      end
    end
    return answer
  end

end
