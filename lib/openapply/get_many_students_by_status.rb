module GetByStatus

  # MULTIPLE STUDENTS DETAILS (full records) - found by status (or statuses)
  ###########################

  # Returns all student details (combines student, guardian and payments records)
  #
  # === Attributes
  #
  # +status+ - enter a valid status (or an array of valid statuses)
  # +options+ currently only {get_payments: true} - default or
  #  {get_payments: false} - 2x faster when false!
  #
  # === Usage
  #  students_details_by_status( @oa, 'applied' )
  #  students_details_by_status( @oa, 'applied', {get_payments: false} )
  #  students_details_by_status( @oa, ['applied','enrolled'], {get_payments: false} )
  #
  # === Returned Data
  # returns the data structured as:
  #   { students:
  #     [
  #       { id: aaa,                     # openapply student id
  #         record: {bbb}                # complete student record
  #         guardians: [ {ccc}, {ddd} ]  # all guardian information
  #         payments:  [ {eee}, {fff} ]  # all payments made via openapply
  #       },
  #       {
  #         id: ggg,                     # openapply student id
  #         record: {hhh}                # complete student record
  #         guardians: [ {iii}, {jjj} ]  # all guardian information
  #         payments:  [ {kkk}, {lll} ]  # all payments made via openapply
  #       }
  #     ]
  #   }
  def many_students_details_by_status( oa_client, status, options={} )

    return {error: 'need openapply client'} unless oa_client.is_a? Openapply::Client

    ids = oa_client.student_ids_by_status(status)

    return { error: 'answer nil' }  if ids.nil?
    return { error: 'ids nil' }     if ids[:student_ids].nil?
    return { students: [] }         if ids[:student_ids].empty?

    # loop through each student
    error_ids       = []
    student_records = []
    ids[:student_ids].each do |id|
      student = oa_client.student_details_by_id( "#{id}", flatten_keys, reject_keys, get_payments )

      error_ids << id                          if student.nil? or
                                                  student[:student].nil? or
                                                  student[:student].empty?
      student_records << student[:student] unless student.nil? or
                                                  student[:student].nil? or
                                                  student[:student].empty?
    end
    return { students: student_records }
  end
  alias_method :students_details,             :get_many_students_details_by_status
  alias_method :students_details_by_status,   :get_many_students_details_by_status
  alias_method :students_details_by_statuses, :get_many_students_details_by_status
  alias_method :get_many_students_details_by_statuses, :get_many_students_details_by_status

  # UTILITIES FOR MULTIPLE STUDENT LOOKUPS -- using recursion
  ########################################

  # LIST OF IDS for a given STATUS
  ################################

  # returns a list of student ids that match a give status (this is recursive -
  # so returns the entire list - even if that list is longer than the api_return_count)
  #
  # ==== Attributes
  # +status+ - a **string** matching one of the OA allowed statuses **OR**
  # status can be an **array** of statuses (matching OA statuses)
  #
  # === Usage
  #   student_ids_by_status('applied')
  #   student_ids_by_statuses(['applied','enrolled'])
  #
  # === Return
  #   {student_ids: [1, 3, 40]}
  # TODO: test with a  mix of good and bad keys
  #       only use good keys be sure count >= 1
  def get_many_students_ids_by_status(status)
    ids = []
    # when a single status is sent
    states = [status] if status.is_a? String
    states = status   if status.is_a? Array
    states.each do |state|
      answer = get_many_student_summaries_by_status(state)

      ids   += answer[:students].map{ |l| l[:id] } unless answer.nil? or
                                                      answer[:students].nil? or
                                                      answer[:students].empty?
    end
    return { student_ids: [] }       if ids.nil? or ids.empty?
    return { student_ids: ids }
  end
  alias_method :all_student_ids_by_status, :get_many_students_ids_by_status
  alias_method :student_ids_by_statuses,   :get_many_students_ids_by_status
  alias_method :student_ids_by_status,     :get_many_students_ids_by_status
  alias_method :student_ids_by_statuses,   :get_many_students_ids_by_status

  # GET STUDENT SUMMARY INFO for a given status -- mostly used to get a list of ids
  ##########################

  # Returns a list of student summaries (in OpenApply's format) that
  # match a give status (this is recursive - so returns the entire list -
  # even if that list is longer than the api_return_count)
  #
  # ==== Attributes
  # +status+ - **MUST BE A STRING** returns the data as is from OpenApply
  #
  # === Usage
  #  get_many_student_summaries_by_status('applied')
  def get_many_student_summaries_by_status(oa_client, status)

    return {error: 'need openapply client'} unless oa_client.is_a? Openapply::Client

    url    = oa_client.build_url_for_many_student_summaries(status)
    answer = oa_client.oa_answer( url )
    return { error: "nil" }             if answer[:students].nil?
    return { students: [] }             if answer[:students].empty?

    page_number = answer[:meta][:pages]
    return answer                       if page_number == 1

    # inspect meta data -- loop until page = 1 (all students found)
    all_students = answer[:students]
    while page_number > 1
      last_student = answer[:students].last
      since_id     = last_student[:id]
      url          = oa_client.build_url_for_many_student_summaries(status,since_id)
      answer       = oa_answer( url )
      page_number  = answer[:meta][:pages]
      all_students += answer[:students]
    end
    return { students: all_students }
  end
  # alias_method :all_student_summaries_by_status, :students_by_status
  alias_method :students,           :get_many_student_summaries_by_status
  alias_method :students_by_status, :get_many_student_summaries_by_status

end
