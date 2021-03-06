# require 'json'

module SpecData
  path = File.join( File.dirname(__FILE__), "data/text" )

  # https://demo.openapply.com/api/v1/students/106/payments/?auth_token=demo_site_api_key
  file = File.join( path, 'student_106_payments.txt' )
  STUDENT_106_PAYMENTS_TEXT  = File.read(file).chomp

  # https://demo.openapply.com/api/v1/students/106/?auth_token=demo_site_api_key
  file = File.join( path, 'student_106_record.txt' )
  STUDENT_106_RECORD_TEXT    = File.read(file).chomp

  # https://demo.openapply.com//api/v1/students?status=applied&count=3
  file = File.join( path, 'status_applied_page_1.txt' )
  STATUS_APPLIED_PAGE_1_TEXT = File.read(file).chomp

  # https://demo.openapply.com//api/v1/students?status=applied&since_id=240&count=3
  file = File.join( path, 'status_applied_page_2.txt' )
  STATUS_APPLIED_PAGE_2_TEXT = File.read(file).chomp

  # # https://demo.openapply.com//api/v1/students?status=applied&since_id=269&count=3
  file = File.join( path, 'status_applied_page_3.txt' )
  STATUS_APPLIED_PAGE_3_TEXT = File.read(file).chomp
  #
  # file = File.join( path, 'status_applied_csv.txt' )
  # STATUS_APPLIED_CSV_TEXT = File.read(file) #.chomp
  #
  # file = File.join( path, 'status_applied_enrolled_csv.txt' )
  # STATUS_APPLIED_ENROLLED_CSV_TEXT = File.read(file) #.chomp

end
