module Utilities

  # MULTIPLE STUDENTS DETAILS (full records) - found by status (or statuses)
  ###########################

  # Returns all student details (combines student, guardian and payments records)
  #
  # === Attributes
  #
  # +status+ - enter a valid status (or an array of valid statuses)
  # +options+ currently only {get_payments: true} - default or
  #  {get_payments: false} - 2x faster when false!
  #
  # === Usage
  #  students_details_by_status('applied')
  #  students_details_by_status( 'applied', {get_payments: false} )
  #  students_details_by_status( ['applied','enrolled'], {get_payments: false} )
  #
  # === Returned Data
  # returns the data structured as:
  #   { students:
  #     [
  #       { id: aaa,                     # openapply student id
  #         record: {bbb}                # complete student record
  #         guardians: [ {ccc}, {ddd} ]  # all guardian information
  #         payments:  [ {eee}, {fff} ]  # all payments made via openapply
  #       },
  #       {
  #         id: ggg,                     # openapply student id
  #         record: {hhh}                # complete student record
  #         guardians: [ {iii}, {jjj} ]  # all guardian information
  #         payments:  [ {kkk}, {lll} ]  # all payments made via openapply
  #       }
  #     ]
  #   }
  def get_students_details_by_status( status, options={} )
    # flatten_keys=[], reject_keys=[], get_payments=true )

    check = check_details_keys_validity(flatten_keys, reject_keys)
    return check     unless check.nil? # or check[:error].nil?

    ids = student_ids_by_status(status)
    return { error: 'answer nil' }  if ids.nil?
    return { error: 'ids nil' }     if ids[:student_ids].nil?
    return { students: [] }         if ids[:student_ids].empty?

    # loop through each student
    error_ids       = []
    student_records = []
    ids[:student_ids].each do |id|
      student = student_details_by_id( "#{id}", flatten_keys, reject_keys, get_payments )

      error_ids << id                          if student.nil? or
                                                  student[:student].nil? or
                                                  student[:student].empty?
      student_records << student[:student] unless student.nil? or
                                                  student[:student].nil? or
                                                  student[:student].empty?
    end
    return { students: student_records }
  end
  alias_method :students_details,             :students_details_by_status
  alias_method :students_details_by_statuses, :students_details_by_status



end
