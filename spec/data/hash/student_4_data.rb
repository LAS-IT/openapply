module SpecData

  # https://demo.openapply.com/api/v1/students/4/payments/?auth_token=demo_site_api_key
  STUDENT_4_PAYMENTS_HASH =
  {
  payments: [
  {
  invoice_status: "Paid",
  type: "Reenrollment",
  invoice_number: 1243,
  amount: "550.0",
  issue_date: "2017-06-27",
  due_date: "2017-07-17",
  payment_method: nil,
  payment_date: nil
  },
  {
  invoice_status: "Paid",
  type: "Application",
  invoice_number: 1257,
  amount: "90.0",
  issue_date: "2017-10-30",
  due_date: "2017-11-19",
  payment_method: "cash",
  payment_date: "2016-08-12"
  }
  ]
  }

  STUDENT_4_RECORD_HASH =
  {
  student: {
  id: 4,
  serial_number: 3,
  custom_id: "3",
  applicant_id: "00000003",
  email: "anneb@eduvo.com",
  first_name: "Anne",
  last_name: "Bennett",
  name: "Anne Bennett",
  other_name: nil,
  preferred_name: nil,
  birth_date: "2007-05-24",
  gender: "female",
  enrollment_year: 2016,
  full_address: "2 Tin Kwong Rd, Hong Kong, Hong Kong",
  address: "2 Tin Kwong Rd",
  address_ii: nil,
  city: "Hong Kong",
  state: nil,
  postal_code: nil,
  country: "Hong Kong",
  grade: "Grade 4",
  campus: "Chatham Campus",
  tags: [
  "Embassy",
  "Athlete",
  "Scholarship",
  "Gifted"
  ],
  status: "enrolled",
  status_changed_at: "2016-09-22",
  managebac_student_id: nil,
  applied_at: "2015-09-08T17:09:00.000+08:00",
  enrolled_at: "2016-09-22T08:00:00.000+08:00",
  inquired_at: "2016-09-03",
  sibling_ids: [ ],
  updated_at: "2017-10-31T10:44:09.000+08:00",
  nationality: "New Zealander",
  student_id: "3",
  passport_id: nil,
  profile_photo: "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/student/avatar/000/000/004/f_jho.jpg?v=1509417849",
  profile_photo_updated_at: "2017-07-11T14:46:44.000+08:00",
  custom_fields: {
  bursary_scholarship: nil,
  language: "English",
  second_language: nil,
  nationality: "New Zealander",
  referral_source: "Employer 雇主",
  middle_name_s: "Emily",
  mobile_phone: "852 4545 1190",
  national_id: "1516950",
  second_nationality: nil,
  home_telephone: "852 2429 1190",
  applicant_lives_with: "Father and Mother",
  siblings: nil,
  prior_school: "Lincoln School",
  prior_school_phone: "+977 14270482",
  prior_school_address_1: "P.O. Box 2673, Rabi Bhawan",
  prior_school_address_2: nil,
  prior_school_city: "Kathmandu",
  prior_school_state: nil,
  prior_school_country: "Nepal",
  prior_school_postal_code: nil,
  school_file: nil,
  has_your_child_attended_school_regularly: "Yes",
  has_your_child_participated_in_any_of_following_programmes: [ ],
  has_your_child_been_referred_for_any_educational_testing: "Yes",
  has_your_child_ever_had_need_for_psychological_counselling: "No",
  has_your_child_ever_been_asked_to_leave_a_previous_school: "No",
  has_your_child_taken_any_standardized_tests_or_external_non_school_e: "No",
  has_your_child_had_any_serious_health_problems_e_g_allergies_epilep: "No",
  health_problem: nil,
  absent_days: nil,
  extra_curricular_interests: "Dancing, Tumbling, Gymnastics",
  terms_amp_conditions: true,
  signature_of_parent: nil,
  place_of_birth_2: nil,
  religion_3: nil,
  file: nil,
  name_of_school: nil,
  school_address: nil,
  phone_number: nil,
  has_your_child_attended_school_regularly_2: nil,
  has_your_child_participated_in_any_of_following_programmes_2: [ ],
  has_your_child_been_referred_for_any_educational_testing_2: nil,
  has_your_child_ever_had_need_for_psychological_counselling_2: nil,
  has_your_child_ever_been_asked_to_leave_a_previous_school_2: nil,
  has_your_child_taken_any_standardized_tests_or_external_non_school_e_2: nil,
  has_your_child_had_any_serious_health_problems_e_g_allergies_epilep_2: nil,
  please_list_your_child_s_extra_curricular_interests_or_any_other_info_2: nil,
  nationality_5: nil,
  nationality_6: nil,
  mailing_address: nil,
  phone: nil,
  fax: nil,
  personal_mobile_father: nil,
  personal_mobile_mother: nil,
  title_position: nil,
  email_3: nil,
  address: nil,
  fax_2: nil,
  title_position_2: nil,
  email_4: nil,
  address_2: nil,
  phone_2: nil,
  fax_3: nil,
  place_of_birth: nil,
  color: nil,
  second_nationality_2: nil,
  terms_amp_conditions_2: true,
  student_pass_expiry_date: nil,
  parent_guardian: [
  {
  id: 350,
  serial_number: nil,
  custom_id: nil,
  name: "Patricia Bennett",
  first_name: "Patricia",
  last_name: "Bennett",
  gender: "female",
  address: "2 Tin Kwong Rd",
  address_ii: nil,
  city: "Hong Kong",
  state: nil,
  postal_code: nil,
  country: "Hong Kong",
  email: "patriciab@eduvo.com",
  parent_role: "Mother",
  updated_at: "2017-07-11T14:46:48.000+08:00",
  managebac_parent_id: nil,
  profile_photo: "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/parent/avatar/000/000/350/3b744808-ab20-4f43-a5d1-b5ab78d6ba8a.jpg?v=1499755608",
  profile_photo_updated_at: "2017-07-11T14:46:48.000+08:00",
  parent_id: nil,
  custom_fields: {
  title: nil,
  treat_parent_as_emergency_contact: "Yes",
  mobile_phone: "+852 9876 1190",
  home_telephone: "852 2429 1190",
  nationality: "New Zealander",
  passport_id: "3994930",
  passport_expiration: "2019-06-19",
  residency_status: "Permanent Resident",
  language: "English",
  employer_company: "B&G Pharmaceuticals",
  title_position: "Sales Representative",
  work_email: "patriciab@eduvo.com",
  work_phone: "852 2421 1190",
  work_address_street_address_1: nil,
  work_address_street_address_2: nil,
  work_address_city: nil,
  work_address_state: nil,
  work_address_country: nil,
  work_address_postal_code: nil,
  parent_residency: nil
  }
  },
  {
  id: 351,
  serial_number: nil,
  custom_id: nil,
  name: "Wesley Bennett",
  first_name: "Wesley",
  last_name: "Bennett",
  gender: "male",
  address: "2 Tin Kwong Rd",
  address_ii: nil,
  city: "Hong Kong",
  state: nil,
  postal_code: nil,
  country: "Hong Kong",
  email: "wesleyb@eduvo.com",
  parent_role: "Father",
  updated_at: "2017-07-11T14:46:48.000+08:00",
  managebac_parent_id: nil,
  profile_photo: "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/parent/avatar/000/000/351/301e6344-ebc7-402e-a3d5-c63d7f4c5119.jpg?v=1499755608",
  profile_photo_updated_at: "2017-07-11T14:46:48.000+08:00",
  parent_id: nil,
  custom_fields: {
  title: nil,
  treat_parent_as_emergency_contact: "Yes",
  mobile_phone: "852 6565 1190",
  home_telephone: "852 4545 1190",
  nationality: "New Zealander",
  passport_id: "4223192",
  passport_expiration: "2019-06-14",
  residency_status: "Permanent Resident",
  language: "English",
  employer_company: "Callahan Motors",
  title_position: "R&D",
  work_email: "wesleyb@eduvo.com",
  work_phone: "852 2323 1174",
  work_address_street_address_1: nil,
  work_address_street_address_2: nil,
  work_address_city: nil,
  work_address_state: nil,
  work_address_country: nil,
  work_address_postal_code: nil,
  parent_residency: nil
  }
  }
  ],
  siblings_information: [
  {
  first_name: "Oscar",
  last_name: "Bennett",
  gender: "Male",
  birth_date: "2008-06-04"
  }
  ],
  emergency_contact: [ ],
  prior_school_list: [
  {
  school_name: "Lansing Eastern High School",
  school_contact_name: "Emily Pohl",
  school_contact_phone: "(517) 755-1050",
  school_country: "United States"
  },
  {
  school_name: "Australian International School, Dhaka",
  school_contact_name: "Rama Moody",
  school_contact_phone: "02-8881344",
  school_country: "Bangladesh"
  }
  ],
  immunization_record: [ ],
  health_information: [ ]
  },
  parent_ids: [
  350,
  351
  ]
  },
  linked: {
  parents: [
  {
  id: 350,
  serial_number: nil,
  custom_id: nil,
  name: "Patricia Bennett",
  first_name: "Patricia",
  last_name: "Bennett",
  gender: "female",
  address: "2 Tin Kwong Rd",
  address_ii: nil,
  city: "Hong Kong",
  state: nil,
  postal_code: nil,
  country: "Hong Kong",
  email: "patriciab@eduvo.com",
  parent_role: "Mother",
  updated_at: "2017-07-11T14:46:48.000+08:00",
  managebac_parent_id: nil,
  profile_photo: "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/parent/avatar/000/000/350/3b744808-ab20-4f43-a5d1-b5ab78d6ba8a.jpg?v=1499755608",
  profile_photo_updated_at: "2017-07-11T14:46:48.000+08:00",
  parent_id: nil,
  custom_fields: {
  title: nil,
  treat_parent_as_emergency_contact: "Yes",
  mobile_phone: "+852 9876 1190",
  home_telephone: "852 2429 1190",
  nationality: "New Zealander",
  passport_id: "3994930",
  passport_expiration: "2019-06-19",
  residency_status: "Permanent Resident",
  language: "English",
  employer_company: "B&G Pharmaceuticals",
  title_position: "Sales Representative",
  work_email: "patriciab@eduvo.com",
  work_phone: "852 2421 1190",
  work_address_street_address_1: nil,
  work_address_street_address_2: nil,
  work_address_city: nil,
  work_address_state: nil,
  work_address_country: nil,
  work_address_postal_code: nil,
  parent_residency: nil
  }
  },
  {
  id: 351,
  serial_number: nil,
  custom_id: nil,
  name: "Wesley Bennett",
  first_name: "Wesley",
  last_name: "Bennett",
  gender: "male",
  address: "2 Tin Kwong Rd",
  address_ii: nil,
  city: "Hong Kong",
  state: nil,
  postal_code: nil,
  country: "Hong Kong",
  email: "wesleyb@eduvo.com",
  parent_role: "Father",
  updated_at: "2017-07-11T14:46:48.000+08:00",
  managebac_parent_id: nil,
  profile_photo: "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/parent/avatar/000/000/351/301e6344-ebc7-402e-a3d5-c63d7f4c5119.jpg?v=1499755608",
  profile_photo_updated_at: "2017-07-11T14:46:48.000+08:00",
  parent_id: nil,
  custom_fields: {
  title: nil,
  treat_parent_as_emergency_contact: "Yes",
  mobile_phone: "852 6565 1190",
  home_telephone: "852 4545 1190",
  nationality: "New Zealander",
  passport_id: "4223192",
  passport_expiration: "2019-06-14",
  residency_status: "Permanent Resident",
  language: "English",
  employer_company: "Callahan Motors",
  title_position: "R&D",
  work_email: "wesleyb@eduvo.com",
  work_phone: "852 2323 1174",
  work_address_street_address_1: nil,
  work_address_street_address_2: nil,
  work_address_city: nil,
  work_address_state: nil,
  work_address_country: nil,
  work_address_postal_code: nil,
  parent_residency: nil
  }
  }
  ]
  }
  }

end
