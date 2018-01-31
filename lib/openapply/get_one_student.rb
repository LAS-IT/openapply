# SINGLE STUDENT API GET CALLS
##############################

module Get

  # @note Get all student details matching the associated id
  # @param ids - (Integer) - ids of student to lookup
  # @param options[:get_payments] (Boolean) - get student payments (or not)
  def one_student_details_by_id( id, options={} )

    get_payments = options[:get_payments]  unless options.nil? or options.empty?
    get_payments ||= true  if get_payments.nil?

    # get full student record and guardian information
    student_info = one_student_record_by_id( "#{id}" )

    # be sure there is student data to process -- if not return an empty record
    return {student: {id: id, empty: []}}      if student_info.nil? or
                                                  student_info[:student].nil?
                                                  student_info[:student].empty?
    student = []
    # extract the student info
    student = student_info[:student]       unless student_info[:student].nil?

    guardians = []
    # extract guardian information
    guardians = student_info[:linked][:parents].dup unless
                                                  student_info[:linked].nil? or
                                                  student_info[:linked].empty? or
                                                  student_info[:linked][:parents].nil?
    payments = []
    # get student payment records
    payment_info = one_student_payments_by_id("#{id}") if get_payments.eql? true
    # extract payment information
    payments = payment_info[:payments].dup unless payment_info.nil? or
                                                  payment_info[:payments].nil?
    # organize the student details
    return  {
              student:
                { id: id,
                  record: student,
                  payments: payments,
                  guardians: guardians,
                },
              guardians: guardians,
            }
  end

  # @note Get one student's primary record matching the associated id
  # @param ids - (Integer) - ids of student to lookup
  # @param options - http options
  def one_student_record_by_id(id, options ={})
    url = "#{api_path}#{id}?auth_token=#{api_key}"
    return oa_answer( url, options )
  end

  # @note Get one student's details matching the associated id
  # @param ids - (Integer) - ids of student to lookup
  # @param options - http options
  def one_student_payments_by_id(id, options={})
    url = "#{api_path}#{id}/payments?auth_token=#{api_key}"
    return oa_answer( url, options )
  end

end
