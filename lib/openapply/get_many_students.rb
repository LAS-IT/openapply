module Get

  def many_student_details( params )
    ids = many_student_ids( params )
    return many_student_details_by_ids( ids )
  end


  def many_student_details_by_ids( ids, options={} )
    return {error: 'no ids provided'} if ids.nil? or ids.empty?
    students  = []
    guardians = []
    ids       = [ids]     unless ids.is_a? Array
    ids.each do |id|
      response = one_student_details_by_id( id, options )
      # pp response
      students  << response[:student]
      guardians << response[:guardians]
    end
    return  {
              students: students,
              guardians: guardians,
            }
  end


  def many_student_ids( params )
    response = many_students_summaries( params )
    ids = response[:students].map{ |kid| kid[:id] }
    { ids: ids }
  end


  def many_ids_updated_time( params )
    response = many_students_summaries( params )
    kids  = response[:students].map{ |kid| {kid[:id] => kid[:updated_at]} }
    rents = response[:guardians].map{ |rent| {rent[:id] => rent[:updated_at]} }
    { ids_updated_at:
      {
        students: kids,
        guardians: rents,
      }
    }
  end



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
  def many_students_summaries( params={} )
    # status=nil,since_id=nil,since_date=nil,count=api_records)
    return {error: 'no query provided'} if params.empty?

    students      = []
    guardians     = []

    count         = params[:count]
    count       ||= api_records()
    since_date    = params[:since_date]
    statuses      = params[:status]
    statuses      = [statuses]          if not statuses.nil? and
                                                statuses.is_a? String
    statuses.each do |status|

      # these values need to be reset for each status loop
      page_number   = nil
      since_id      = params[:since_id]

      # loop until all pages recieved
      while  page_number.nil? or page_number > 1
        url = url_for_many_students_summaries(status, since_id, since_date, count)
        answer        = oa_answer( url )
        break        if answer.nil? or answer[:students].empty?

        students     += answer[:students]
        guardians    += answer[:linked][:parents]

        last_student  = answer[:students].last
        since_id      = last_student[:id]
        # since_id      = (answer[:students].last)[:id]
        page_number   = answer[:meta][:pages]
      end
    end
    return  {
              students: students,
              guardians: guardians,
            }
  end


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
  # alias_method :students_custom_url, :url_for_many_students_summaries
  # alias_method :students_query_url,  :url_for_many_students_summaries

end
