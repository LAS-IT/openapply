# SINGLE STUDENT API GET CALLS
##############################

module Get

  # STUDENT FULL RECORD AND PAYMENTS COMBINED
  ###########################################
  # Combines all student info into one record
  #
  # ==== Attributes
  # * +student_id+ - openapply student_id
  # * +options+ at the moment only {get_payments: true} (default) or
  #   {get_payments: true} - 2x faster when false (if payment info not needed)!
  #
  # === Usage
  #  get_one_student_details_by_id( 95 )
  #  get_one_student_details_by_id( 95, {get_payments: true} )
  #  get_one_student_details_by_id( 95, {get_payments: false} )
  #
  # === Returned Data
  # returns the data structured as:
  #   { student:
  #     { id: aaa,                     # student id
  #       record: {bbb}                # complete student record
  #       guardians: [ {ccc}, {ddd} ]  # all guardian information
  #       payments:  [ {eee}, {fff} ]  # all payments made via openapply
  #     }
  #   }
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
    student = student_info[:student]

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
    return { student:
              { id: id,
                record: student,
                payments: payments,
                guardians: guardians,
              }
            }
  end
  alias_method :student_details,       :one_student_details_by_id
  alias_method :student_details_by_id, :one_student_details_by_id

  # ONE STUDENT RECORD
  #####################

  # Summary record for ONE student - this API return has the parent info 2x!
  #
  # ==== Attributes
  # # @student_id - openapply student_id
  # * @options - see httparty options
  #
  # ==== Example code
  #  @demo = Openapply.new
  #  @demo.get_one_student_record_by_id(96)
  def one_student_record_by_id(id, options ={})
    url = "#{api_path}#{id}?auth_token=#{api_key}"
    return oa_answer( url, options )
  end
  alias_method :student,       :one_student_record_by_id
  alias_method :student_by_id, :one_student_record_by_id


  # ONE STUDENT PAYMENT INFO
  ##########################

  # Payment details for ONE student
  #
  # ==== Attributes
  # * +student_id+ - openapply student_id
  # * +options+ - see httparty options
  #
  # ==== Example code
  #  @demo = Openapply.new
  #  @demo.get_one_student_payments_by_id(96)
  def one_student_payments_by_id(id, options={})
    url = "#{api_path}#{id}/payments?auth_token=#{api_key}"
    return oa_answer( url, options )
  end
  alias_method :payments,       :one_student_payments_by_id
  alias_method :payments_by_id, :one_student_payments_by_id

end
