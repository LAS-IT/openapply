module Get

  # MULTIPLE STUDENTS DETAILS (full records) - found by status (or statuses)
  ###########################

  # Returns all student details (combines student, guardian and payments records)
  #
  # === Attributes
  #
  # **flatten_keys** - brings these keys to the top level - prepending the group name to the key name -- we usually use:
  #  flatten_keys = [:custom_fields]
  # **reject keys** -- removes the data matching these keys -- we usually use:
  #  reject_keys = [:parent_guardian] (since this is duplicated)
  #
  # === Usage
  #  students_details_by_status('applied')
  #  students_details_by_status('applied', [:custom_fields], [:parent_guardian])
  #  students_details_by_statuses(['applied','enrolled'])
  #  students_details_by_statuses(['applied','enrolled'], [:custom_fields], [:parent_guardian])
  #
  # === Returned Data
  # returns the data structured as:
  #   { students:
  #     [
  #       { id: xxx,                     # openapply student id
  #         record: {xxx}                # complete student record
  #         guardians: [ {xxx}, {xxx} ]  # all guardian information
  #         payments: [ {xxx}, {xxx} ]   # all payments made via openapply
  #       },
  #       {
  #         id: xxx,                     # openapply student id
  #         record: {xxx}                # complete student record
  #         guardians: [ {xxx}, {xxx} ]  # all guardian information
  #         payments: [ {xxx}, {xxx} ]   # all payments made via openapply
  #       }
  #     ]
  #   }
  def students_details_by_status( status, flatten_keys=[], reject_keys=[] )
    ids = student_ids_by_status(status)
    return { error: 'answer nil' }  if ids.nil?
    return { error: 'ids nil' }     if ids[:student_ids].nil?
    return { students: [] }         if ids[:student_ids].empty?

    # loop through each student
    error_ids       = []
    student_records = []
    ids[:student_ids].each do |id|
      student = student_details_by_id( "#{id}", flatten_keys, reject_keys )

      error_ids << id                          if student.nil? or
                                                  student[:student].nil? or
                                                  student[:student].empty?
      student_records << student[:student] unless student.nil? or
                                                  student[:student].nil? or
                                                  student[:student].empty?
    end
    return { students: student_records }
  end
  alias_method :students_details, :students_details_by_status
  alias_method :students_details_by_statuses, :students_details_by_status

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
  def student_ids_by_status(status)
    ids = []
    # when a single status is sent
    states = [status] if status.is_a? String
    states = status   if status.is_a? Array
    states.each do |state|
      answer = students_by_status(state)

      ids   += answer[:students].map{ |l| l[:id] } unless answer.nil? or
                                                      answer[:students].nil? or
                                                      answer[:students].empty?
    end
    return { student_ids: [] }       if ids.nil? or ids.empty?
    return { student_ids: ids }
  end
  alias_method :all_student_ids_by_status, :student_ids_by_status
  alias_method :student_ids_by_statuses, :student_ids_by_status

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
  #  students_by_status('applied')
  def students_by_status(status)
    url = students_custom_url(status)
    answer = oa_answer( url )
    return { error: "nil" }             if answer[:students].nil?
    return { students: [] }             if answer[:students].empty?

    page_number = answer[:meta][:pages]
    return answer                       if page_number == 1

    # inspect meta data -- loop until page = 1 (all students found)
    all_students = answer[:students]
    while page_number > 1
      last_student = answer[:students].last
      since_id     = last_student[:id]
      url = students_custom_url(status,since_id)
      answer       = oa_answer( url )
      page_number  = answer[:meta][:pages]
      all_students += answer[:students]
    end
    return { students: all_students }
  end
  # alias_method :all_student_summaries_by_status, :students_by_status
  alias_method :students, :students_by_status


  # CUSTOM QUERIES - recursion utlities
  ################

  # Executes a custom query **(non-recursive)** to get a list of students
  # summaries matching the allowed attribute's criteria -- used to build
  # recursive or custom queries (within what is allowed by OpenApply API)
  #
  # ==== Attributes
  # * +status+ - match status (be sure it is in the list of OpenApply status)
  # * +since_id+ - get all ids matching the criteria LARGER than the given number
  # * +since_date+ - get all records updated after the given date (YYYY-MM-DD) or
  # Date and Time (YYYY-MM-DD HH:MM:SS) - 24 hour clock (not sure about timeszone)
  # * +count+ - return a custom number of records (no more than 1000)
  #
  # ==== Usage
  #  students_query(nil, since_id=95, since_date=2017-01-01, count=2)
  #
  # ==== returned
  #  { students:
  #    [
  #      { student summary data from openapply api },
  #      { student summary data from openapply api },
  #    ]
  #  }
  def students_query(status=nil, since_id=nil, since_date=nil, count=api_records)
    return { error: "invalid count" } unless count.to_i >= 1

    url    = students_custom_url(status, since_id, since_date, count)
    answer = oa_answer( url )
    return { error: "nil answer" }        if answer.nil?
    return { error: "nil students" }      if answer[:students].nil?
    return { students: [] }               if answer[:students].empty?
    return answer
  end
  alias_method :students_custom_query, :students_query

  # Builds a custom url (with domain) to get a list of students summaries matching
  # the attribute's criteria (but not do a Query) - returns a URL
  #
  # ==== Attributes
  # * +status+ - match status (be sure it is in the list of OpenApply status)
  # * +since_id+ - get all ids matching the criteria LARGER than the given number
  # * +since_date+ - get all records updated after the given date (YYYY-MM-DD) or
  # Date and Time (YYYY-MM-DD HH:MM:SS) - 24 hour clock (not sure about timeszone)
  # * +count+ - return a custom number of records (no more than 1000)
  #
  # ==== Return Format
  # "/api/v1/students/?status=applied&since_id=96&since_date=2017-01-25&count=2&auth_token=319d9axxxxxxx"
  def students_query_url(status=nil, since_id=nil, since_date=nil, count=api_records)
    url_options = []
    url_options << "status=#{status}"         unless status.to_s.eql? ""
    url_options << "since_id=#{since_id}"     unless since_id.to_s.eql? ""
    url_options << "since_date=#{since_date}" unless since_date.to_s.eql? ""
    url_options << "count=#{count}"
    url_options << "auth_token=#{api_key}"

    return "#{api_path}?#{url_options.join('&')}"
  end
  alias_method :students_custom_url, :students_query_url

end
