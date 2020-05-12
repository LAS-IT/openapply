require 'json'

module Openapply
  # OpenApply API Page
  # https://dev.faria.co/oa/#resources-reference
  module Put

    # @note Update one student's Student ID (Field in OpenApply must be currently Blank)
    # @param oa_id - (Integer) - id of student to update
    # @param student_id - (Integer) - id to put in student_id field
    # PUT https://<school_subdomain>.openapply.com/api/v1/students/1/student_id
    # PUT Data student_id=123456
    def update_student_id(oa_id, student_id)
      # url = "#{api_path}#{oa_id}"
      url = "#{api_path}/students/#{oa_id}"
      return oa_answer( url, {student_id: student_id})
    end

    # # @note Update one student's status
    # # @param oa_id - (Integer) - id of student to update
    # # @param status - (string) - status to update for student
    # # PUT https://<school_subdomain>.openapply.com/api/v1/students/1/status
    # # PUT Data status=Applied
    # def update_student_status(oa_id, status)
    #   # url = "#{api_path}#{oa_id}/status"
    #   url = "#{api_path}/students/#{oa_id}/status"
    #   return oa_answer( url, {status: status})
    # end

  end
end
