module Get

  # SINGLE STUDENT CODE
  #####################


  # STUDENT FULL RECORD
  #####################

  # Summary record for ONE student - this API return has the parent info 2x!
  #
  # ==== Attributes
  # # @student_id - openapply student_id
  # * @options - see httparty options
  #
  # ==== Example code
  #  @demo = Openapply.new
  #  @demo.student_by_id(96)
  def student_by_id(student_id, options ={})
    url = "#{api_path}#{student_id}?auth_token=#{api_key}"
    return oa_answer( url, options )
  end
  alias_method :student, :student_by_id


  # STUDENT PAYMENT INFO
  ######################

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


  # STUDENT FULL RECORD AND PAYMENTS COMBINED
  ###########################################

  # Combines the student_by_id & payments_by_id into one call with all the data
  #
  # ==== Attributes
  # * +student_id+ - openapply student_id
  # * +flatten_keys+ - an array of keys to bring to the top level
  # (with this key prepened) -- default (blank does nothing)
  # * +reject_keys+ - an array of keys to remove from the data -- default (blank does nothing)
  #
  # === Returned Data
  # returns the data structured as:
  #   { student:
  #     { id: xxx,
  #       record: {xxx}      # complete student record
  #       guardians: [ {} ]  # all guardian information
  #       payments: [ {} ]   # all payments made via openapply
  #     }
  #   }
  def student_details_by_id(id, flatten_keys=[], reject_keys=[])

    # # be sure flatten_keys are in an array
    return {error: "invalid flatten_keys - need array"}  unless flatten_keys.is_a? Array
    # # be sure reject_keys are in an array
    return {error: "invalid reject_keys - need array"}   unless reject_keys.is_a? Array
    # # test if any values are non-symbols (remain after removing symbols)
    return {error: "invalid flatten_keys - use symbols"} if flatten_keys.reject{|k| k.is_a? Symbol}.count > 0
    # # test if any values are non-symbols (remain after removing symbols)
    return {error: "invalid reject_keys - use symbols"}  if reject_keys.reject{|k| k.is_a? Symbol}.count > 0

    # get full student record and guardian information
    student_info = student_by_id( "#{id}" )
    # get student payment records
    payment_info = payments_by_id( "#{id}" )

    # be sure there is student data to process -- if not return an empty record
    return {student: {id: id, empty: []}}        if student_info.nil? or
                                                    student_info[:student].nil?
                                                    student_info[:student].empty?
    student = []
    guardians = []
    # extract guardian information
    guardians = student_info[:linked][:parents].dup unless
                                                    student_info[:linked].nil? or
                                                    student_info[:linked].empty? or
                                                    student_info[:linked][:parents].nil?
    payments = []
    # extract payment information
    payments = payment_info[:payments].dup   unless payment_info.nil? or
                                                    payment_info[:payments].nil?
    # if flatten and reject are not set - set them so they do nothing
    flatten_keys = [:flatten_no_keys] if flatten_keys.nil? or flatten_keys.empty?
    reject_keys  = [:reject_no_keys]  if reject_keys.nil?  or reject_keys.empty?

    # extract the student info into the desired format (and removes \n in strings)
    # student = student_info[:student] - this is the effective result wo
    # flatten/reject keys
    student = flatten_record(student_info[:student], flatten_keys, reject_keys)

    # process guardian records - the same way student records
    # (loop on guardian arrary since there can be multiple parents)
    g_flat = []
    guardians = guardians.each do |guard|
      next                 if guard.empty?
      g_flat << flatten_record( guard, flatten_keys, reject_keys )
    end                unless guardians.empty?
    guardians = g_flat unless g_flat.empty?

    # organize the student details
    return { student:
              { id: id,
                record: student,
                payments: payments,
                guardians: guardians,
              }
            }
  end
  alias_method :student_details, :student_details_by_id

  # UTILITIES
  ###########

  # return value & remove linebreaks & trim spaces (if a string)
  def clean_data( value )
    return value.gsub("\n",' ').strip   if value.is_a? String
    return value
  end

  # This method preprocesses records - brings keys to the top level and
  # removes fields and removes \n from strings
  #
  # === Attributes
  # * +hash+ -- **ONE students** student_details
  # * +flatten_keys+ -- keys to bring to the top level (with top key prepended)
  # * +reject_keys+ -- remove data matching these keys
  # TODO: add recursion?
  def flatten_record(hash, flatten_keys=[:flatten_no_keys],reject_keys=[:reject_no_keys])
    answer = {}

    # loop through each key value of the student record
    hash.each do |key,val|
      # skip loop if this key matches a value to remove
      next                               if reject_keys.include? key

      # put data back into hash if not to be flattened
      answer[key] = clean_data(val)  unless flatten_keys.include? key

      # if current key matches a flatten value & HAS nested data values
      # then bring nested data to top level
      val.each do |k,v|
        # remove any nested values if they match a reject_key
        next if reject_keys.include? k

        # (prepend flatten_key_to_current_key to prevent conflicts)
        new_key = "#{key.to_s}_#{k.to_s}".to_sym
        # clean the data and add back to to top level with a new key
        answer[new_key] = clean_data(v)
      end                                if flatten_keys.include?(key) and
                                            not val.empty?
    end
    return answer
  end

end
