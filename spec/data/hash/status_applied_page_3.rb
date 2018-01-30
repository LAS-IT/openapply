module SpecData

  # https://demo.openapply.com//api/v1/students?status=applied&since_id=269&count=3&auth_token=demo_site_api_key
  STATUS_APPLIED_PAGE_3_HASH =
  {
    students: [
          { id: 270,
            serial_number: 125,
            custom_id: "125",
            applicant_id: "00000125",
            email: "fatuma@eduvo.com",
            first_name: "Fatuma",
            last_name: "Katlego",
            name: "Fatuma Katlego",
            other_name: nil,
            preferred_name: nil,
            birth_date: "2010-10-14",
            gender: "female",
            enrollment_year: 2016,
            full_address: "259 Queen's Rd E, Hong Kong, Hong Kong",
            address: "259 Queen's Rd E",
            address_ii: nil,
            city: "Hong Kong",
            state: nil,
            postal_code: nil,
            country: "Hong Kong",
            grade: "Kindergarten",
            campus: "Kowloon Campus",
            tags: [ ],
            status: "applied",
            status_changed_at: "2016-05-02",
            managebac_student_id: nil,
            applied_at: "2016-05-02T08:00:00.000+08:00",
            enrolled_at: nil,
            inquired_at: "2016-04-28",
            sibling_ids: [ ],
            updated_at: "2017-07-11T14:46:44.000+08:00",
            nationality: "Kenyan",
            student_id: "125",
            passport_id: nil,
            profile_photo: "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/student/avatar/000/000/270/aa1acc69-a9d0-446f-81c7-1737946c6efe.jpg?v=1499755604",
            profile_photo_updated_at: "2017-07-11T14:46:44.000+08:00",
            parent_ids: [
                509
            ]
          },
          { id: 271,
            serial_number: 126,
            custom_id: "126",
            applicant_id: "00000126",
            email: "beatriz@eduvo.com",
            first_name: "Beatriz",
            last_name: "Santos",
            name: "Beatriz Santos",
            other_name: nil,
            preferred_name: nil,
            birth_date: "2010-12-22",
            gender: "female",
            enrollment_year: 2016,
            full_address: "399 Lockhart Rd, Hong Kong, Hong Kong",
            address: "399 Lockhart Rd",
            address_ii: nil,
            city: "Hong Kong",
            state: nil,
            postal_code: nil,
            country: "Hong Kong",
            grade: "Kindergarten",
            campus: "Kowloon Campus",
            tags: [ ],
            status: "applied",
            status_changed_at: "2016-09-07",
            managebac_student_id: nil,
            applied_at: "2016-09-07T08:00:00.000+08:00",
            enrolled_at: nil,
            inquired_at: "2016-09-03",
            sibling_ids: [ ],
            updated_at: "2017-07-11T14:46:45.000+08:00",
            nationality: "Brazilian",
            student_id: "126",
            passport_id: nil,
            profile_photo: "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/student/avatar/000/000/271/7886bdac-f029-4c55-9532-d50e6bb48c3a.jpg?v=1499755605",
            profile_photo_updated_at: "2017-07-11T14:46:45.000+08:00",
            parent_ids: [
                510,
                511
            ]
        }
    ],
    linked: {
        parents: [
            {
                id: 509,
                serial_number: 309,
                custom_id: "309",
                name: "Duma Katlego",
                first_name: "Duma",
                last_name: "Katlego",
                gender: "male",
                address: nil,
                address_ii: nil,
                city: nil,
                state: nil,
                postal_code: nil,
                country: "",
                email: "dumak@eduvo.com",
                parent_role: "Grandfather",
                updated_at: "2017-07-11T14:46:48.000+08:00",
                managebac_parent_id: nil,
                profile_photo: "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/parent/avatar/000/000/509/efcdca82-0303-4253-a4bf-8cfb0a3da2cf.jpg?v=1499755608",
                profile_photo_updated_at: "2017-07-11T14:46:48.000+08:00",
                parent_id: "309",
                custom_fields: {
                    title: nil,
                    treat_parent_as_emergency_contact: nil,
                    mobile_phone: "852 1312 1114",
                    home_telephone: nil,
                    nationality: "Kenyan",
                    passport_id: nil,
                    passport_expiration: nil,
                    residency_status: nil,
                    language: nil,
                    employer_company: nil,
                    title_position: nil,
                    work_email: nil,
                    work_phone: nil,
                    work_address_street_address_1: "59 Parkes Street",
                    work_address_street_address_2: nil,
                    work_address_city: "Hong Kong",
                    work_address_state: nil,
                    work_address_country: "Hong Kong",
                    work_address_postal_code: nil,
                    parent_residency: nil
                }
            },
            {
                id: 510,
                serial_number: 310,
                custom_id: "310",
                name: "Rafael Santos",
                first_name: "Rafael",
                last_name: "Santos",
                gender: "male",
                address: nil,
                address_ii: nil,
                city: nil,
                state: nil,
                postal_code: nil,
                country: "",
                email: "rafael@eduvo.com",
                parent_role: "Father",
                updated_at: "2017-07-11T14:46:48.000+08:00",
                managebac_parent_id: nil,
                profile_photo: "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/parent/avatar/000/000/510/b0b59993-fbc2-4df1-8056-679b704cdbd1.jpg?v=1499755608",
                profile_photo_updated_at: "2017-07-11T14:46:48.000+08:00",
                parent_id: "310",
                custom_fields: {
                    title: nil,
                    treat_parent_as_emergency_contact: nil,
                    mobile_phone: "852 1310 1114",
                    home_telephone: nil,
                    nationality: "Brazilian",
                    passport_id: nil,
                    passport_expiration: nil,
                    residency_status: nil,
                    language: nil,
                    employer_company: nil,
                    title_position: nil,
                    work_email: nil,
                    work_phone: nil,
                    work_address_street_address_1: "18 Sha Tin Centre St",
                    work_address_street_address_2: nil,
                    work_address_city: "Hong Kong",
                    work_address_state: nil,
                    work_address_country: "Hong Kong",
                    work_address_postal_code: nil,
                    parent_residency: nil
                }
            },
            {
                id: 511,
                serial_number: 311,
                custom_id: "311",
                name: "Ana Clara Santos",
                first_name: "Ana Clara",
                last_name: "Santos",
                gender: "female",
                address: nil,
                address_ii: nil,
                city: nil,
                state: nil,
                postal_code: nil,
                country: "",
                email: "anaclara@eduvo.com",
                parent_role: "Mother",
                updated_at: "2017-07-11T14:46:48.000+08:00",
                managebac_parent_id: nil,
                profile_photo: "https://openapply-sandbox-devel-01.s3.amazonaws.com/uploads/parent/avatar/000/000/511/1cc758ff-1589-4273-87ff-e35104314b27.jpg?v=1499755608",
                profile_photo_updated_at: "2017-07-11T14:46:48.000+08:00",
                parent_id: "311",
                custom_fields: {
                    title: nil,
                    treat_parent_as_emergency_contact: nil,
                    mobile_phone: "852 2793 1114",
                    home_telephone: nil,
                    nationality: "Brazilian",
                    passport_id: nil,
                    passport_expiration: nil,
                    residency_status: nil,
                    language: nil,
                    employer_company: nil,
                    title_position: nil,
                    work_email: nil,
                    work_phone: nil,
                    work_address_street_address_1: "118 Caine Road",
                    work_address_street_address_2: nil,
                    work_address_city: "Hong Kong",
                    work_address_state: nil,
                    work_address_country: "Hong Kong",
                    work_address_postal_code: nil,
                    parent_residency: nil
                }
            }
        ]
    },
    meta: {
        pages: 1,
        per_page: "3"
    }

}

end
