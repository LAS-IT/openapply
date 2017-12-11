require 'axlsx'

# CODE THAT TRANSFORMS STUDENT DATA INTO XLSX DATA
##################################################

module ConvertToXlsx

  # XLSX CODE
  ###########

  # Queries by status to get a list of students details of a given status
  # and converts the result to a XLSX Object (Axlsx::Package) with headers
  # (based on keys sent)
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
  def students_as_xlsx_by_status( status,
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
    students_xlsx    = students_array_to_xlsx( students_array )

    # example how to save the xlsx object as a file
    # students_xlsx.serialize("spec/data/xlsx/students_from_oa.xlsx")

    return students_xlsx
  end
  alias_method :students_as_xlsx_by_statuses, :students_as_xlsx_by_status


  # Given an array convert to XLSX Object (Axlsx::Package)
  #
  # ==== Attributes
  # +array+ - expects a hash of students_details (should be flattened to use custom fields)
  def students_array_to_xlsx(student_array)
    xlsx_obj = Axlsx::Package.new do |p|
      p.workbook.add_worksheet(:name => "Students from OpenApply") do |sheet|
        student_array.each{ |r| sheet.add_row r }
      end
      # to save the xlsx object as a file
      # p.serialize("spec/data/xlsx/students_from_oa.xlsx")
    end
    return xlsx_obj
  end

  def send_xlsx_to_remote_server( data, srv_hostname, srv_username,
                                  srv_path_file, srv_file_permissions="0750",
                                  ssl_options={}
                                )
    return false                  unless data.is_a? Axlsx::Package
    xfer = data.to_stream()           if data.is_a? Axlsx::Package
    send_data_to_remote_server( xfer, srv_hostname, srv_username,
                                srv_path_file, srv_file_permissions,
                                ssl_options
                              )
  end

end
