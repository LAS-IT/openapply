module Get

  # Creates a custom query (non-recursive) to get a list of students summaries
  # matching the allowed attribute's criteria
  #
  # ==== Attributes
  # * +status+ - match status (be sure it is in the list of OpenApply status)
  # * +since_id+ - get all ids matching the criteria LARGER than the given number
  # * +since_date+ - get all records updated after the given date (YYYY-MM-DD) or
  # Date and Time (YYYY-MM-DD HH:MM:SS) - 24 hour clock (not sure about timeszone)
  # * +count+ - return a custom number of records (no more than 1000)
  #
  # ==== Example code
  #  @demo = Openapply.new
  #  # return: any status (nil), any id greater than 95 updated since 2017-01-01 &
  #  # return only 2 records at a time
  #  @demo.custom_students_query(nil, since_id=95, since_date=2017-01-01, count=2)
  def students_query(status=nil, since_id=nil, since_date=nil, count=api_records)
    return { error: "invalid count" } unless count.to_i >= 1

    url    = students_custom_url(status, since_id, since_date, count)
    answer = oa_answer( url )
    return { error: "nil answer" }        if answer.nil?
    return { error: "nil students" }      if answer[:students].nil?
    return { student_ids: [] }            if answer[:students].empty?
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
  # ==== Example Code
  #  @demo = Openapply.new
  #  @demo.custom_students_url(status='applied', since_id=96, since_date='2017-01-25', count=2)
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

  # returns a list of student ids that match a give status (this is recursive -
  # so returns the entire list - even if that list is longer than the api_return_count)
  #
  # ==== Attributes
  # * +status+ - match status (be sure it is in the list of OpenApply status)
  #
  # ==== Example code
  #  @demo = Openapply.new
  #  @demo.student_ids_by_status('applied')
  #
  # ==== Return Format
  # {:student_ids=>[95, 106, 240, ..., 582]}
  def student_ids_by_status(status)
    answer = students_by_status(status)
    return { error: "nil answer" }   if answer.nil?
    return { error: "nil students" } if answer[:students].nil?
    return { student_ids: [] }       if answer[:students].empty?

    ids  = answer[:students].map{ |l| l[:id] }
    return { student_ids: ids }
  end
  alias_method :all_student_ids_by_status, :student_ids_by_status


  # returns a list of student summaries (in OpenApply's format) that
  # match a give status (this is recursive - so returns the entire list -
  # even if that list is longer than the api_return_count)
  #
  # ==== Attributes
  # * +status+ - match status (be sure it is in the list of OpenApply status)
  def students_by_status(status)
    url = students_custom_url(status)
    answer = oa_answer( url )
    return { error: "no students found" } if answer[:students].nil?
    return { students: [] }               if answer[:students].empty?

    page_number = answer[:meta][:pages]
    return answer                         if page_number == 1

    # inspect meta data -- loop until page = 1
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


  # returns a list of student with all details (gaurdians & payments) that
  # match a give status (this is recursive - so returns the entire list - even
  # if that list is longer than the api_return_count)
  #
  # ==== Attributes
  # * +status+ - match status (be sure it is in the list of OpenApply status)
  def students_details_by_status( status, flatten_keys=[], reject_keys=[] )
    ids = student_ids_by_status(status)
    return { error: 'answer nil' }  if ids.nil?
    return { error: 'ids nil' }     if ids[:student_ids].nil?
    return { error: 'ids empty' }   if ids[:student_ids].empty?

    # loop through each student
    error_ids       = []
    student_records = []
    ids[:student_ids].each do |id|
      student = student_details_by_id( "#{id}", flatten_keys, reject_keys )

      error_ids << id                       if student.nil? or
                                                    student[:student].nil? or
                                                    student[:student].empty?
      student_records << student[:student]  unless student.nil? or
                                                    student[:student].nil? or
                                                    student[:student].empty?
    end

    return { students: [], error_ids: error_ids } if student_records.empty?
    return { students: student_records }
  end
  alias_method :students_details, :students_details_by_status

  # # TODO: build queries that collects changed by date
  # # get summary info with a status (useful to get ids - no custom_fields)
  # def students_by_since_id(since_id, status = nil, date = nil)
  #     url = "#{@api_path}?count=#{api_records}&auth_token=#{@api_key}"
  #   elsif date.nil? or date == ""
  #     url = "#{@api_path}?status=#{status}&count=#{api_records}&auth_token=#{@api_key}"
  #   else
  #     url = "#{@api_path}?status=#{status}&since_date=#{date}&count=#{api_records}&auth_token=#{@api_key}"
  #   end
  #   return oa_answer( url, options )
  # end
  #
  #
  # # TODO: build queries that collects changed by date
  # # get summary info with a status (useful to get ids - no custom_fields)
  # def student_summaries_by_since_date(since_date, since_id = nil, status = nil)
  #     url = "#{@api_path}?count=#{api_records}&auth_token=#{@api_key}"
  #   elsif since_date.nil? or since_date == ""
  #     url = "#{@api_path}?status=#{status}&count=#{api_records}&auth_token=#{@api_key}"
  #   else
  #     url = "#{@api_path}?status=#{status}&since_date=#{since_date}&count=#{@api_records}&auth_token=#{@api_key}"
  #   end
  #   return oa_answer( url, options )
  # end

end
