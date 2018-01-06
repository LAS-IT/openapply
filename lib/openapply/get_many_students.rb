module Get

  # Executes a custom query - recursively to get all students summaries
  # matching the given criteria
  #
  # ==== Attributes
  # +options+ - query options
  # * +status+ - match status (be sure it is in the list of OpenApply status)
  # * +since_id+ - get all ids matching the criteria LARGER than the given number
  # * +since_date+ - get all records updated after the given date (YYYY-MM-DD) or
  # Date and Time (YYYY-MM-DD HH:MM:SS) - 24 hour clock (not sure about timeszone)
  # * +count+ - return a custom number of records (no more than 1000)
  #
  # ==== Usage
  #  students_query( { status: 'applied', since_id: 95,
  #                    since_date: '2017-01-01', count: 2 } )
  #
  # ==== returned
  #  { students:
  #    [
  #      { student summary data from openapply api },
  #      { student summary data from openapply api },
  #    ]
  #  }
  def all_students_summaries( options={} )
    # status=nil,since_id=nil,since_date=nil,count=api_records)
    return {error: 'no query provided'} if options.empty?

    count         = api_records()
    count         = options[:count]       unless options[:count].nil? or
                                                  options[:count].empty?
    statuses      = nil
    statuses      = options[:status]      unless options[:status].nil? or
                                                  options[:status].empty?
    statuses      = [statuses]                if statuses.is_a? String

    since_id      = nil
    since_id      = options[:since_id]    unless options[:since_id].nil? or
                                                  options[:since_id].empty?
    since_date    = nil
    since_date    = options[:since_date]  unless options[:since_date].nil? or
                                                  options[:since_date].empty?
    students  = []
    page_number   = nil
    count         = 1                  unless count.to_s.to_i >= 1

    statuses.each do |status|
    # loop until all records are acquired (page_number == 1)
      while  page_number.nil? or page_number > 1
        url = url_for_many_students_summaries(status, since_id, since_date, count)
        answer        = oa_answer( url )
        return { error: "no answer" } if answer.nil?

        students += answer[:students]
        break                         if answer[:students].empty?

        last_student  = answer[:students].last
        since_id      = last_student[:id]
        # since_id      = (answer[:students].last)[:id]
        page_number   = answer[:meta][:pages]
      end
    end
    return { students: students }
  end


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
  def many_students_summaries_one_page( status=nil, since_id=nil,
                                        since_date=nil, count=api_records )
    return { error: "invalid record return count" } unless count.to_i >= 1
    return { error: "no query info given"}              if status.nil? and
                                                           since_id.nil? and
                                                           since_date.nil?
    url    = url_for_many_student_summaries(status, since_id, since_date, count)
    answer = oa_answer( url )
    return { error: "nil answer" }        if answer.nil?
    return { error: "nil students" }      if answer[:students].nil?
    return { students: [] }               if answer[:students].empty?
    return answer
  end
  alias_method :students_custom_query, :many_students_summaries_one_page
  alias_method :students_query,        :many_students_summaries_one_page

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
  def url_for_many_students_summaries(status=nil, since_id=nil,
                                      since_date=nil, count=api_records)
    url_options = []
    url_options << "status=#{status}"         unless status.to_s.eql? ""
    url_options << "since_id=#{since_id}"     unless since_id.to_s.eql? ""
    url_options << "since_date=#{since_date}" unless since_date.to_s.eql? ""
    url_options << "count=#{count}"
    url_options << "auth_token=#{api_key}"

    return "#{api_path}?#{url_options.join('&')}"
  end
  alias_method :students_custom_url, :url_for_many_students_summaries
  alias_method :students_query_url,  :url_for_many_students_summaries

end
