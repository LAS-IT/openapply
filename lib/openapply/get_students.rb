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
  #
  # ==== Return Format
  # { :students=>
  #     [{:id=>96,
  #       :serial_number=>86,
  #       :custom_id=>"86",
  #       :applicant_id=>"00000086",
  #       :email=>"Jerry.Patel@eduvo.com",
  #       :first_name=>"Jerry",
  #       :last_name=>"Patel",
  #       ...,
  #       :sibling_ids=>[],
  #       :updated_at=>"2017-07-11T14:46:44.000+08:00",
  #       :...,
  #       :parent_ids=>[267, 268]},
  #      {:id=>98,
  #       :serial_number=>87,
  #       :custom_id=>"87",
  #       :applicant_id=>"00000087",
  #       :email=>"Robin.Barnes@eduvo.com",
  #       :first_name=>"Robin",
  #       :last_name=>"Barnes",
  #       :sibling_ids=>[],
  #       :updated_at=>"2017-07-11T14:46:44.000+08:00",
  #       ...,
  #       :profile_photo=>
  #        "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/student/avatar/000/000/098/f_rep.jpg?v=1499755604",
  #       :profile_photo_updated_at=>"2017-07-11T14:46:44.000+08:00",
  #       :parent_ids=>[406, 407]}],
  #   :linked=>
  #     {:parents=>
  #       [{:id=>267,
  #         :serial_number=>256,
  #         :custom_id=>"256",
  #         :name=>"Jane Patel",
  #         :first_name=>"Jane",
  #         :last_name=>"Patel",
  #         ...,
  #         :profile_photo=>
  #          "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/parent/avatar/000/000/267/patel_mom.jpg?v=1499755607",
  #         :profile_photo_updated_at=>"2017-07-11T14:46:47.000+08:00",
  #         :parent_id=>"256",
  #         :custom_fields=>
  #          {:title=>"",
  #           :treat_parent_as_emergency_contact=>"Yes",
  #           :home_telephone=>"",
  #           ...,
  #           :parent_residency=>"Citizen"}},
  #        { ... },
  #        {:id=>407,
  #         :serial_number=>nil,
  #         :custom_id=>nil,
  #         :name=>"Boris Barnes",
  #         :first_name=>"Boris",
  #         :last_name=>"Barnes",
  #         ...,
  #         :profile_photo=>
  #          "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/parent/avatar/000/000/407/6e9b4e89-0aa8-413c-8239-2990ea6b0e6d.jpg?v=1499755608",
  #         :profile_photo_updated_at=>"2017-07-11T14:46:48.000+08:00",
  #         :parent_id=>nil,
  #         :custom_fields=>
  #          {:title=>nil,
  #           :treat_parent_as_emergency_contact=>"Yes",
  #           :mobile_phone=>"852 6565 1190",
  #           :home_telephone=>"852 4545 1190",
  #           ...,
  #           :parent_residency=>nil}}]},
  #   :meta=>{:pages=>170, :per_page=>"2"}}
  def students_custom_query(status=nil, since_id=nil, since_date=nil, count=api_records)
    return { error: "invalid count" } unless count.to_i >= 1

    url    = students_custom_url(status, since_id, since_date, count)
    answer = oa_answer( url )
    return { error: "nil answer" }        if answer.nil?
    return { error: "nil students" }      if answer[:students].nil?
    return { student_ids: [] }            if answer[:students].empty?
    return answer
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
  # ==== Example Code
  #  @demo = Openapply.new
  #  @demo.custom_students_url(status='applied', since_id=96, since_date='2017-01-25', count=2)
  #
  # ==== Return Format
  # "/api/v1/students/?status=applied&since_id=96&since_date=2017-01-25&count=2&auth_token=319d9axxxxxxx"
  def students_custom_url(status=nil, since_id=nil, since_date=nil, count=api_records)
    url_options = []
    url_options << "status=#{status}"         unless status.to_s.eql? ""
    url_options << "since_id=#{since_id}"     unless since_id.to_s.eql? ""
    url_options << "since_date=#{since_date}" unless since_date.to_s.eql? ""
    url_options << "count=#{count}"
    url_options << "auth_token=#{api_key}"

    return "#{api_path}?#{url_options.join('&')}"
  end


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
  #
  # ==== Return Format
  # {:students=>
  #   [{:id=>95,
  #     :serial_number=>85,
  #     :custom_id=>"85",
  #     :applicant_id=>"00000085",
  #     :email=>"Richard.Washington@eduvo.com",
  #     :first_name=>"Richard",
  #     :last_name=>"Washington",
  #     :name=>"Richard Washington",
  #     ...,
  #     :parent_ids=>[492, 493]},
  #    {:id=>106,
  #     :serial_number=>90,
  #     :custom_id=>"90",
  #     :applicant_id=>"00000090",
  #     :email=>"Henry.Epelbaum@eduvo.com",
  #     :first_name=>"Samuel",
  #     :last_name=>"Epelbaum",
  #     ...,
  #     :parent_ids=>[265, 266]}],
  # :linked=>
  #   {:parents=>
  #     [{:id=>492,
  #       :serial_number=>nil,
  #       :custom_id=>nil,
  #       :name=>"Philippa Washington",
  #       :first_name=>"Philippa",
  #       :last_name=>"Washington",
  #       ...,
  #       :custom_fields=>
  #        {:title=>nil,
  #         :treat_parent_as_emergency_contact=>nil,
  #         :mobile_phone=>"852 6712 1196",
  #         :home_telephone=>"+852 9954 1179",
  #         ...,
  #         :parent_residency=>nil}},
  #      {:id=>493,
  #       :serial_number=>nil,
  #       :custom_id=>nil,
  #       :name=>"Fred Washington",
  #       :first_name=>"Fred",
  #       :last_name=>"Washington",
  #       ...,
  #       :address=>"High Street 110",
  #       :address_ii=>nil,
  #       :city=>"Hong Kong",
  #       :state=>nil,
  #       :postal_code=>nil,
  #       :country=>"Hong Kong",
  #       :email=>"fredw@eduvo.com",
  #       :parent_role=>"Father",
  #       :updated_at=>"2017-07-11T14:46:48.000+08:00",
  #       ...,
  #       :custom_fields=>
  #        {:title=>nil,
  #         :treat_parent_as_emergency_contact=>nil,
  #         :mobile_phone=>"+852 9954 1179",
  #         :home_telephone=>"+852 9954 1179",
  #         ...,
  #         :parent_residency=>nil}}]},
  # :meta=>{:pages=>1, :per_page=>"100"}}
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
  #
  # ==== Return Format
  #  {students: [
  #    {
  #       id=95,
  #       record: {},
  #       guardians: [],
  #       payments: []
  #    },
  #    {
  #       id=487,
  #       record: {},
  #       guardians: [],
  #       payments: []
  #    }
  #  ]}
  # for example:
  # :students=>
  #   [{:id=>"95",
  #     :record=>
  #      {:id=>95,
  #       :serial_number=>85,
  #       ...,
  #       :custom_fields=>
  #        {:language=>"English",
  #         :nationality=>"American (United States)",
  #         :referral_source=>"Friends",
  #         ...,
  #         :siblings_information=>
  #          [{:first_name=>"Jerry",
  #            :last_name=>"Washington",
  #            :gender=>"Male",
  #            :birth_date=>"2008-06-04"}],
  #         :emergency_contact=>[],
  #         :immunization_record=>[],
  #         :health_information=>[]},
  #       :parent_ids=>[492, 493]},
  #     :payments=>[],
  #     :guardians=>
  #      [{:id=>492,
  #        :serial_number=>nil,
  #        :custom_id=>nil,
  #        :name=>"Philippa Washington",
  #        :first_name=>"Philippa",
  #        :last_name=>"Washington",
  #        ...,
  #        :custom_fields=>
  #         {:title=>nil,
  #          :treat_parent_as_emergency_contact=>nil,
  #          :mobile_phone=>"852 6712 1196",
  #          :home_telephone=>"+852 9954 1179",
  #          ...,
  #          :parent_residency=>nil}},
  #       {:id=>493,
  #        :serial_number=>nil,
  #        :custom_id=>nil,
  #        :name=>"Fred Washington",
  #        :first_name=>"Fred",
  #        :last_name=>"Washington",
  #        ...,
  #        :custom_fields=>
  #         {:title=>nil,
  #          :treat_parent_as_emergency_contact=>nil,
  #          :mobile_phone=>"+852 9954 1179",
  #          :home_telephone=>"+852 9954 1179",
  #          ...,
  #          :parent_residency=>nil}}]},
  #   { ... },
  #   {:id=>"582",
  #      :record=>
  #       {:id=>582,
  #        :serial_number=>437,
  #        :custom_id=>nil,
  #        :applicant_id=>"00000437",
  #        :email=>"s3@example.com",
  #        :first_name=>"Ada",
  #        :last_name=>"Junior",
  #        ...,
  #        :profile_photo=>
  #         "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/student/avatar/000/000/582/boy-01.jpg?v=1500883583",
  #        :profile_photo_updated_at=>"2017-07-24T16:06:23.000+08:00",
  #        :custom_fields=>
  #         {:language=>nil,
  #          :nationality=>nil,
  #          :referral_source=>nil,
  #          ...,
  #          :prior_school_list=>[],
  #          :immunization_record=>[],
  #          :health_information=>[]},
  #        :parent_ids=>[]},
  #      :payments=>[],
  #      :guardians=>[]}]}
  def students_details_by_status(status)
    ids = all_student_ids_by_status(status)
    return { error: 'answer nil' }  if ids.nil?
    return { error: 'ids nil' }     if ids[:student_ids].nil?
    return { error: 'ids empty' }   if ids[:student_ids].empty?

    # loop through each student
    error_ids       = []
    student_records = []
    ids[:student_ids].each do |id|
      # get each kids details w_billing
      student = student_details_by_id( "#{id}" )

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
  # alias_method :all_student_records_w_billing_by_status, :students_details_by_status
  # alias_method :all_students_all_data_by_status, :students_details_by_status
  alias_method :students_details, :students_details_by_status

  def students_as_csv_by_status(status,keys)
    # some code
  end

  def students_hash_to_array(students, student_keys=[], guardian_keys=[], payment_keys=[])
    headers  = []
    headers  = student_keys.map{ |k| "student_" + k.to_s } unless student_keys.empty?
    headers += guardian_keys.map{|k| "guardian_" + k.to_s } unless guardian_keys.empty?
    headers += payment_keys.map{ |k| "payment_" + k.to_s } unless payment_keys.empty?
    # Rails.logger.debug "HEADERS #{headers.inspect}"

    array   = []
    array  << headers
    return array      if students.empty?

    students.each do |record|
      row = []

      # Rails.logger.debug "RECORD #{record.inspect}"

      student_keys.each{ |key| row << nil }                  if student.blank?
      student_keys.each{ |key| row << student[key] }     unless student.blank?

      # add the first (primary) parent / guardian
      gaurdian_1 = record[:gaurdians].first
      @gaurdian_fields.each{ |key| row << nil }                 if gaurdian_1.blank?
      @gaurdian_fields.each{ |key| row << gaurdian_1[key] } unless gaurdian_1.blank?

      # add the second (other) parent / guardian
      gaurdian_2 = record[:gaurdians].second
      @gaurdian_fields.each{ |key| row << nil }                 if gaurdian_2.blank?
      @gaurdian_fields.each{ |key| row << gaurdian_2[key] } unless gaurdian_2.blank?

      # only add the last payment in this status
      payment = record[:payments].last
      @payment_fields.each{ |key| row << nil }                  if payment.blank?
      @payment_fields.each{ |key| row << payment[key] }     unless payment.blank?

      array << row
    end

    return array
  end

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
