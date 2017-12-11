require 'csv'

# CODE THAT TRANSFORMS STUDENT DATA
###################################

module ConvertToCsv


  # Queries by status to get a list of students details of a given status
  # and converts the result to a CSV string with headers (based on keys sent)
  #
  # ==== Attributes
  # * +status+ - hash to convert to an array
  # * +flatten_keys+ - an array of keys to bring to the top level
  # (with this key prepened) -- default (blank does nothing)
  # * +reject_keys+ - an array of keys to remove from the data -- default (blank does nothing)
  # * +student_keys+ - [:id, :name] - include student record keys
  # * +guardian_info+ - include guardian record info {count: 2, keys: [:id, :name]}
  # * +payment_info+ - include payment info {count: 2, order: :newest, keys: [:date, :amount]}
  # * guardian & payment info options:
  #  count: 2 -- how many parent or payment records to return)
  #  keys: [:id, :date] -- an array of keys of data to return
  #  order: :newest -- the order to return payments :newest (most recent first - default) or :oldest
  def students_as_csv_by_status(  status,
                                  flatten_keys=[], reject_keys=[],
                                  student_keys=[],
                                  guardian_info={}, payment_info={})
    #
    check = check_details_keys_validity(flatten_keys, reject_keys)
    return check           unless check.nil? # or check[:error].nil?
    # check = check_header_keys_validity(student_keys, guardian_info, payment_info)
    # return check    unless check.nil?
    #
    students_array  = students_as_array_by_status(  status,
                                  flatten_keys, reject_keys,
                                  student_keys, guardian_info, payment_info )
    #
    return students_array      if students_array.is_a? Hash
    #
    student_csv_txt = students_array_to_csv( students_array )
  end
  alias_method :students_as_csv_by_statuses, :students_as_csv_by_status

  # Given an array convert to CSV string
  #
  # ==== Attributes
  # +array+ - expects a hash of students_details (should be flattened to use custom fields)
  def students_array_to_csv(array)
    return ""              if array.nil? or array.empty?
    # https://stackoverflow.com/questions/4822422/output-array-to-csv-in-ruby
    csv_string = CSV.generate do |csv|
      array.each do |row|
        csv << row
      end
    end
    return csv_string
  end

end
