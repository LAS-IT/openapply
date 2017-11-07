module Get

  # Record details for ONE student - this API return has the parent info 2x!
  #
  # @param
  # ==== Attributes
  # * +student_id+ - openapply student_id
  # * +options+ - see httparty options
  #
  # ==== Example code
  #  @demo = Openapply.new
  #  @demo.student_by_id(96)
  #
  # ==== Result
  # {:student=>
  #   {:id=>96,
  #    :serial_number=>86,
  #    :custom_id=>"86",
  #    :applicant_id=>"00000086",
  #    :email=>"Jerry.Patel@eduvo.com",
  #    :first_name=>"Jerry",
  #    :last_name=>"Patel",
  #    ...,
  #    :profile_photo=>
  #     "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/student/avatar/000/000/096/m_9.jpg?v=1499755604",
  #    :profile_photo_updated_at=>"2017-07-11T14:46:44.000+08:00",
  #    :custom_fields=>
  #     {:language=>"Hindi",
  #      :nationality=>"Indian (India)",
  #      :referral_source=>"Friends",
  #      :middle_name_s=>"Danesh",
  #      :mobile_phone=>"852 4545 1195",
  #      ...,
  #      :school_file=>
  #       {:id=>73,
  #        :filename=>"Robert_Patel_Report.pdf",
  #        :url=>"https://demo.openapply.com/api/v1/secure_download/files/73"},
  #      :has_your_child_attended_school_regularly=>"Yes",
  #      ...,
  #      :parent_guardian=>
  #       [{:id=>268,
  #         :serial_number=>257,
  #         :custom_id=>"257",
  #         :name=>"James Patel",
  #         :first_name=>"James",
  #         :last_name=>"Patel",
  #         ...,
  #         :custom_fields=>
  #          {:title=>"CFO",
  #           :treat_parent_as_emergency_contact=>"Yes",
  #           :home_telephone=>"",
  #           ...,
  #           :parent_residency=>"Citizen"}},
  #        {:id=>267,
  #         :serial_number=>256,
  #         :custom_id=>"256",
  #         ...,
  #         :profile_photo=>
  #          "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/parent/avatar/000/000/267/patel_mom.jpg?v=1499755607",
  #         :profile_photo_updated_at=>"2017-07-11T14:46:47.000+08:00",
  #         :parent_id=>"256",
  #         :custom_fields=>
  #          {:title=>"",
  #           :treat_parent_as_emergency_contact=>"Yes",
  #           ...,
  #           :parent_prior_countries_list=>nil,
  #           :parent_residency=>"Citizen"}}],
  #      :siblings_information=>
  #       [{:first_name=>"Deidre",
  #         :last_name=>"Patel",
  #         :gender=>"Female",
  #         :birth_date=>"2008-06-06"}],
  #      :emergency_contact=>[],
  #      :prior_school_list=>
  #       [{:school_name=>"Michael Varner Elementary",
  #         :school_country=>"United States",
  #         :school_contact_name=>"Ann Farris",
  #         :school_contact_phone=>"(415) 777-0876"},
  #        {:school_name=>"ISS International School",
  #         :school_contact_name=>"Taylor Michaels",
  #         :school_contact_phone=>"65 6235 5844",
  #         :school_country=>"Singapore"}],
  #      :immunization_record=>[],
  #      :health_information=>[]},
  #    :parent_ids=>[268, 267]},
  #  :linked=>
  #     {:parents=>
  #       [{:id=>268,
  #         :serial_number=>257,
  #         :custom_id=>"257",
  #         :name=>"James Patel",
  #         :first_name=>"James",
  #         :last_name=>"Patel",
  #         ...,
  #         :address=>"1641 26th Avenue",
  #         :address_ii=>"",
  #         :city=>"San Francisco",
  #         :state=>"California",
  #         :postal_code=>"94122",
  #         :country=>"United States",
  #         ...,
  #         :custom_fields=>
  #          {:title=>"CFO",
  #           :treat_parent_as_emergency_contact=>"Yes",
  #           :home_telephone=>"",
  #           ...,
  #           :parent_residency=>"Citizen"}},
  #        {:id=>267,
  #         :serial_number=>256,
  #         :custom_id=>"256",
  #         :name=>"Jane Patel",
  #         :first_name=>"Jane",
  #         ...,
  #         :profile_photo=>
  #          "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/parent/avatar/000/000/267/patel_mom.jpg?v=1499755607",
  #         :profile_photo_updated_at=>"2017-07-11T14:46:47.000+08:00",
  #         :parent_id=>"256",
  #         :custom_fields=>
  #          {:title=>"",
  #           :treat_parent_as_emergency_contact=>"Yes",
  #           ...,
  #           :parent_residency=>"Citizen"}}]}}
  def student_by_id(student_id, options ={})
    url = "#{api_path}#{student_id}?auth_token=#{api_key}"
    return oa_answer( url, options )
  end
  alias_method :student, :student_by_id


  # Payment details for ONE student
  #
  # ==== Attributes
  # * +student_id+ - openapply student_id
  # * +options+ - see httparty options
  #
  # ==== Example code
  #  @demo = Openapply.new
  #  @demo.payments_by_id(96)
  #
  # ==== Result
  # {:payments=>
  #   [{:invoice_status=>"Paid",
  #     :type=>"Application",
  #     :invoice_number=>1047,
  #     :amount=>"90.0",
  #     :issue_date=>"2016-03-11",
  #     :due_date=>"2016-03-31",
  #     :payment_method=>"check",
  #     :payment_date=>"2013-03-07"}]}
  def payments_by_id(student_id, options={})
    url = "#{api_path}#{student_id}/payments?auth_token=#{api_key}"
    return oa_answer( url, options )
  end
  alias_method :payments, :payments_by_id


  # Combines the student_by_id & payments_by_id into one call with all the data
  #
  # ==== Attributes
  # * +student_id+ - openapply student_id
  #
  # ==== Example code
  #  @demo = Openapply.new
  #  @demo.student_details_by_id(96)
  #
  # ==== Results
  # NOTE: gaurdian info is moved to the top level - along with ID
  #  {student: {
  #       id=95,
  #       record: {},
  #       guardians: [],
  #       payments: []
  #    }
  #  }
  #
  # for example:
  #
  # {:student=>
  #   {:id=>96,
  #    :record=>
  #     {:id=>96,
  #      :serial_number=>86,
  #      :custom_id=>"86",
  #      :applicant_id=>"00000086",
  #      :email=>"Jerry.Patel@eduvo.com",
  #      :first_name=>"Jerry",
  #      :last_name=>"Patel",
  #      ...,
  #      :profile_photo=>
  #       "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/student/avatar/000/000/096/m_9.jpg?v=1499755604",
  #      :profile_photo_updated_at=>"2017-07-11T14:46:44.000+08:00",
  #      :custom_fields=>
  #       {:language=>"Hindi",
  #        :nationality=>"Indian (India)",
  #        :referral_source=>"Friends",
  #        ...,
  #        :siblings_information=>
  #         [{:first_name=>"Deidre",
  #           :last_name=>"Patel",
  #           :gender=>"Female",
  #           :birth_date=>"2008-06-06"}],
  #        :emergency_contact=>[],
  #        :immunization_record=>[],
  #        :health_information=>[]},
  #      :parent_ids=>[268, 267]},
  #    :payments=>
  #     [{:invoice_status=>"Paid",
  #       :type=>"Application",
  #       :invoice_number=>1047,
  #       :amount=>"90.0",
  #       :issue_date=>"2016-03-11",
  #       :due_date=>"2016-03-31",
  #       :payment_method=>"check",
  #       :payment_date=>"2013-03-07"}],
  #    :guardians=>
  #     [{:id=>268,
  #       :serial_number=>257,
  #       :custom_id=>"257",
  #       :name=>"James Patel",
  #       :first_name=>"James",
  #       :last_name=>"Patel",
  #       ...,
  #       :custom_fields=>
  #        {:title=>"CFO",
  #         :treat_parent_as_emergency_contact=>"Yes",
  #         :home_telephone=>"",
  #         ...,
  #         :parent_residency=>"Citizen"}},
  #      {:id=>267,
  #       :serial_number=>256,
  #       :custom_id=>"256",
  #       :name=>"Jane Patel",
  #       :first_name=>"Jane",
  #       :last_name=>"Patel",
  #       ...,
  #       :profile_photo=>
  #        "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/parent/avatar/000/000/267/patel_mom.jpg?v=1499755607",
  #       :profile_photo_updated_at=>"2017-07-11T14:46:47.000+08:00",
  #       :parent_id=>"256",
  #       :custom_fields=>
  #        {:title=>"",
  #         :treat_parent_as_emergency_contact=>"Yes",
  #         :home_telephone=>"",
  #         ...,
  #         :parent_residency=>"Citizen"}}]}}
  def student_details_by_id(id, flatten = false)
    student_info = student_by_id( "#{id}" )
    payment_info = payments_by_id( "#{id}" )

    # be sure there is data to process
    return {student: {id: id, empty: []}}    if student_info.nil? or
                                                student_info[:student].nil?
                                                student_info[:student].empty?
    guardians = []
    guardians = student_info[:linked][:parents].dup unless
                                                student_info[:linked].nil? or
                                                student_info[:linked].empty? or
                                                student_info[:linked][:parents].nil?
    payments = []
    payments = payment_info[:payments].dup   unless payment_info.nil? or
                                                payment_info[:payments].nil?
    # process meaningful data
    record = student_info[:student].dup
    # remove duplicated parental data fields
    record[:custom_fields][:parent_guardian] = nil

    return { student:
              { id: id,
                record: record,
                payments: payments,
                guardians: guardians,
              }
            }
  end
  alias_method :student_details, :student_details_by_id

end
