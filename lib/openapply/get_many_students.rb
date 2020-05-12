module Openapply
  module GetManyStudents

    # @note Get all student details matching the criteria in params
    # @param params[:status] - (String or Array of Strings) - list the status wanted
    # @param params[:since_id] - (Integer) - get all ids matching the criteria LARGER than the given number
    # @param params[:since_date] - (String) - all records updated after the given date (YYYY-MM-DD) or Date and Time (YYYY-MM-DD HH:MM:SS) - 24 hour clock (not sure about timeszone)
    # @param params[:count] - (Integer) - The number of customers to return - large numbers need a large timeout
    # @param options[:get_payments] (Boolean) - get student payments
    def many_students_details( params, options={} )
      ids = many_students_ids( params )
      return {error: "need an array of ids"}          unless ids[:ids]
      return many_students_details_by_ids( ids[:ids], options )
    end

    # @note Get all student details matching the criteria in params
    # @param ids - (Array of Integers) - list ids wanted to lookup
    # @param options[:get_payments] (Boolean) - get student payments
    def many_students_details_by_ids( ids, options={} )
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
      return  { students: students,
                guardians: guardians,
              }
    end

    # @note Get all student ids matching the criteria in params
    # @param params[:status] - (String or Array of Strings) - list the status wanted
    # @param params[:since_id] - (Integer) - get all ids matching the criteria LARGER than the given number
    # @param params[:since_date] - (String) - all records updated after the given date (YYYY-MM-DD) or Date and Time (YYYY-MM-DD HH:MM:SS) - 24 hour clock (not sure about timeszone)
    # @param params[:count] - (Integer) - The number of customers to return - large numbers need a large timeout
    def many_students_ids( params )
      response = many_students_summaries( params )
      ids = response[:students].map{ |kid| kid[:id] }
      { ids: ids }
    end

    # @note Get all student ids & guardian ids with associated last updated timestamp (matching the criteria in params)
    # @param params[:status] - (String or Array of Strings) - list the status wanted
    # @param params[:since_id] - (Integer) - get all ids matching the criteria LARGER than the given number
    # @param params[:since_date] - (String) - all records updated after the given date (YYYY-MM-DD) or Date and Time (YYYY-MM-DD HH:MM:SS) - 24 hour clock (not sure about timeszone)
    # @param params[:count] - (Integer) - The number of customers to return - large numbers need a large timeout
    def many_ids_updated_time( params )
      response = many_students_summaries( params )
      kids  = response[:students].map{ |kid| {kid[:id] => kid[:updated_at]} }
      rents = response[:guardians].map{ |rent| {rent[:id] => rent[:updated_at]} }
      { ids_updated_at:
        { students: kids,
          guardians: rents,
        }
      }
    end

    # @note Get all student summaries matching the criteria in params
    # @param params[:status] - (String or Array of Strings) - list the status wanted
    # @param params[:since_id] - (Integer) - get all ids matching the criteria LARGER than the given number
    # @param params[:since_date] - (String) - all records updated after the given date (YYYY-MM-DD) or Date and Time (YYYY-MM-DD HH:MM:SS) - 24 hour clock (not sure about timeszone)
    # @param params[:count] - (Integer) - The number of customers to return - large numbers need a large timeout
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
        page_number   = nil
        since_id      = params[:since_id]

        # loop until all pages recieved
        while  page_number.nil? or page_number > 1
          url = url_for_many_students_summaries(status, since_id, since_date, count)
          answer        = oa_answer( url )
          break        if answer.nil? or answer[:students].nil? or answer[:students].empty?
          students     += answer[:students]
          guardians    += answer[:linked][:parents]
          last_student  = answer[:students].last
          since_id      = last_student[:id]
          page_number   = answer[:meta][:pages].to_i unless answer[:meta].nil?
          page_number   = 0                              if answer[:meta].nil?
        end
      end
      return  { students: students,
                guardians: guardians,
              }
    end

    # @note Get url to query for student summaries matching the criteria in params
    # @param status - (String or Array of Strings) - list the status wanted
    # @param since_id - (Integer) - get all ids matching the criteria LARGER than the given number
    # @param since_date - (String) - all records updated after the given date (YYYY-MM-DD) or Date and Time (YYYY-MM-DD HH:MM:SS) - 24 hour clock (not sure about timeszone)
    # @param count - (Integer) - The number of customers to return - large numbers need a large timeout
    def url_for_many_students_summaries(status=nil, since_id=nil,
                                        since_date=nil, count=api_records)
      url_options = []
      url_options << "status=#{status}"         unless status.to_s.eql? ""
      url_options << "since_id=#{since_id}"     unless since_id.to_s.eql? ""
      url_options << "since_date=#{since_date}" unless since_date.to_s.eql? ""
      url_options << "count=#{count}"

      return "#{api_path}/students/?#{url_options.join('&')}"
    end

  end
end
