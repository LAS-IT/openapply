# require 'csv'
# require 'roo'
# require 'axlsx'
require 'spec_helper'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.describe Openapply do
  before(:each) do
    @options = {}
    @oa = Openapply::Client.new

    # stub_request(:get, "http://demo.openapply.com/api/v1/students/1?auth_token=demo_site_api_key")
    @url_kid_1  = "#{@oa.api_path}1?auth_token=#{@oa.api_key}"
    stub_request(:get, "http://#{@oa.api_url}#{@url_kid_1}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_1_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/1/payments?auth_token=demo_site_api_key")
    @url_pay_1  = "#{@oa.api_path}1/payments?auth_token=#{@oa.api_key}"
    stub_request(:get, "http://#{@oa.api_url}#{@url_pay_1}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_1_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/4?auth_token=demo_site_api_key")
    @url_kid_4  = "#{@oa.api_path}4?auth_token=#{@oa.api_key}"
    stub_request(:get, "http://#{@oa.api_url}#{@url_kid_4}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_4_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/4/payments?auth_token=demo_site_api_key")
    @url_pay_4  = "#{@oa.api_path}4/payments?auth_token=#{@oa.api_key}"
    stub_request(:get, "http://#{@oa.api_url}#{@url_pay_4}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_4_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/5?auth_token=demo_site_api_key")
    @url_kid_5  = "#{@oa.api_path}5?auth_token=#{@oa.api_key}"
    stub_request(:get, "http://#{@oa.api_url}#{@url_kid_5}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_5_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/5/payments?auth_token=demo_site_api_key")
    @url_pay_5  = "#{@oa.api_path}5/payments?auth_token=#{@oa.api_key}"
    stub_request(:get, "http://#{@oa.api_url}#{@url_pay_5}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_5_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/6?auth_token=demo_site_api_key")
    @url_kid_6  = "#{@oa.api_path}6?auth_token=#{@oa.api_key}"
    stub_request(:get, "http://#{@oa.api_url}#{@url_kid_6}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_6_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/6/payments?auth_token=demo_site_api_key")
    @url_pay_6  = "#{@oa.api_path}6/payments?auth_token=#{@oa.api_key}"
    stub_request(:get, "http://#{@oa.api_url}#{@url_pay_6}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_6_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/7?auth_token=demo_site_api_key")
    @url_kid_7  = "#{@oa.api_path}7?auth_token=#{@oa.api_key}"
    stub_request(:get, "http://#{@oa.api_url}#{@url_kid_7}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_7_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/7/payments?auth_token=demo_site_api_key")
    @url_pay_7  = "#{@oa.api_path}7/payments?auth_token=#{@oa.api_key}"
    stub_request(:get, "http://#{@oa.api_url}#{@url_pay_7}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_7_PAYMENTS_HASH.to_json)

    # stub_request(:get, "http://demo.openapply.com/api/v1/students/95?auth_token=demo_site_api_key")
    @url_kid_95  = "#{@oa.api_path}95?auth_token=#{@oa.api_key}"
    stub_request(:get, "http://#{@oa.api_url}#{@url_kid_95}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_95_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/95/payments?auth_token=demo_site_api_key")
    @url_pay_95  = "#{@oa.api_path}95/payments?auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_pay_95}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_95_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/106?auth_token=demo_site_api_key")
    @url_kid_106  = "#{@oa.api_path}106?auth_token=#{@oa.api_key}"
    stub_request(:get, "http://#{@oa.api_url}#{@url_kid_106}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_106_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/106/payments?auth_token=demo_site_api_key")
    @url_pay_106  = "#{@oa.api_path}106/payments?auth_token=#{@oa.api_key}"
    stub_request(:get, "http://#{@oa.api_url}#{@url_pay_106}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_106_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/240?auth_token=demo_site_api_key")
    @url_kid_240  = "#{@oa.api_path}240?auth_token=#{@oa.api_key}"
    stub_request(:get, "http://#{@oa.api_url}#{@url_kid_240}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_240_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/240/payments?auth_token=demo_site_api_key")
    @url_pay_240  = "#{@oa.api_path}240/payments?auth_token=#{@oa.api_key}"
    stub_request(:get, "http://#{@oa.api_url}#{@url_pay_240}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_240_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/240?auth_token=demo_site_api_key")
    @url_kid_267  = "#{@oa.api_path}267?auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_kid_267}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_267_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/240/payments?auth_token=demo_site_api_key")
    @url_pay_267  = "#{@oa.api_path}267/payments?auth_token=#{@oa.api_key}"
    stub_request(:get, "http://#{@oa.api_url}#{@url_pay_267}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_267_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/240?auth_token=demo_site_api_key")
    @url_kid_268  = "#{@oa.api_path}268?auth_token=#{@oa.api_key}"
    stub_request(:get, "http://#{@oa.api_url}#{@url_kid_268}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_268_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/240/payments?auth_token=demo_site_api_key")
    @url_pay_268  = "#{@oa.api_path}268/payments?auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_pay_268}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_268_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/240?auth_token=demo_site_api_key")
    @url_kid_269  = "#{@oa.api_path}269?auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_kid_269}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_269_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/240/payments?auth_token=demo_site_api_key")
    @url_pay_269  = "#{@oa.api_path}269/payments?auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_pay_269}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_269_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/240?auth_token=demo_site_api_key")
    @url_kid_270  = "#{@oa.api_path}270?auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_kid_270}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_270_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/240/payments?auth_token=demo_site_api_key")
    @url_pay_270  = "#{@oa.api_path}270/payments?auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_pay_270}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_270_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/240?auth_token=demo_site_api_key")
    @url_kid_271  = "#{@oa.api_path}271?auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_kid_271}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_271_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/240/payments?auth_token=demo_site_api_key")
    @url_pay_271  = "#{@oa.api_path}271/payments?auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_pay_271}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_271_PAYMENTS_HASH.to_json)

    # https://demo.openapply.com/api/v1/students?status=applied&count=3&auth_token=demo_site_api_key
    @url_status_summary_p_1 = "#{@oa.api_path}?status=applied&count=3&auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_status_summary_p_1}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STATUS_APPLIED_PAGE_1_HASH.to_json)
    # https://demo.openapply.com//api/v1/students?status=applied&since_id=240&count=3&auth_token=demo_site_api_key
    @url_status_summary_p_2 = "#{@oa.api_path}?status=applied&since_id=240&count=3&auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_status_summary_p_2}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STATUS_APPLIED_PAGE_2_HASH.to_json)
    # https://demo.openapply.com/api/v1/students?status=applied&since_id=269&count=3&auth_token=demo_site_api_key
    @url_status_summary_p_3 = "#{@oa.api_path}?status=applied&since_id=269&count=3&auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_status_summary_p_3}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STATUS_APPLIED_PAGE_3_HASH.to_json)

    # COUNT RETURN 5
    # https://demo.openapply.com/api/v1/students/?status=applied&count=5&auth_token=demo_site_api_key
    @url_status_applied_5 = "#{@oa.api_path}?status=applied&count=5&auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_status_applied_5}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STATUS_5_APPLIED_RECORDS_HASH.to_json)
    # https://demo.openapply.com/api/v1/students/?status=accepted&count=5&auth_token=demo_site_api_key
    @url_status_accepted_5 = "#{@oa.api_path}?status=accepted&count=5&auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_status_accepted_5}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STATUS_5_ACCEPTED_RECORDS_HASH.to_json)
    # https://demo.openapply.com/api/v1/students/?status=enrolled&count=5&auth_token=demo_site_api_key
    @url_status_enrolled_5 = "#{@oa.api_path}?status=enrolled&count=5&auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_status_enrolled_5}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STATUS_5_ENROLLED_RECORDS_HASH.to_json)
    # https://demo.openapply.com/api/v1/students/?status=bad&count=5&auth_token=demo_site_api_key
    @url_status_bad_5 = "#{@oa.api_path}?status=bad&count=5&auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_status_bad_5}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STATUS_5_BAD_RECORDS_HASH.to_json)
    #
    # COUNT RETURN 10
    # https://demo.openapply.com/api/v1/students/?status=applied&count=10&auth_token=demo_site_api_key
    @url_status_applied_10 = "#{@oa.api_path}?status=applied&count=10&auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_status_applied_10}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STATUS_APPLIED_PAGES_ALL_HASH.to_json)
  end

  # context "axlsx basic tests" do
  #   # DISABLED until AXLSX can use RubyZip 1.2.1 or later
  #   it "convert an empty array of students_details into a xlsx object" do
  #     allow(@oa).to receive(:api_records) { 10 }
  #     student_array = []
  #     test_answer = @oa.students_array_to_xlsx(student_array)
  #     # pp test_answer.class
  #     # pp test_answer.is_a? Axlsx::Package
  #     stream = test_answer.to_stream() if test_answer.is_a? Axlsx::Package
  #     # roo_file = Roo::Excelx.new( stream )
  #     wb = nil
  #     expect{ wb = Roo::Excelx.new(stream) }.to_not raise_error
  #     expect( wb.cell(1,1) ).to eq(nil)
  #     expect( wb.cell(2,1) ).to eq(nil)
  #     # adds quotes and removes .0 in numbers
  #     # pp wb.to_csv
  #     # expect( wb.to_csv ).to eq SpecData::ROO_CSV_TEXT
  #   end
  #   it "convert an populated array of students_details into a xlsx object" do
  #     allow(@oa).to receive(:api_records) { 5 }
  #     student_array = SpecData::STATUS_APPLIED_ENROLLED_ARRAY
  #     test_answer = @oa.students_array_to_xlsx(student_array)
  #     # pp test_answer.class
  #     # pp test_answer.is_a? Axlsx::Package
  #     stream = test_answer.to_stream() if test_answer.is_a? Axlsx::Package
  #     # roo_file = Roo::Excelx.new( stream )
  #     wb = nil
  #     expect{ wb = Roo::Excelx.new(stream) }.to_not raise_error
  #     expect( wb.cell(1,1) ).to eq('student_id')
  #     expect( wb.cell(2,1) ).to eq(95)
  #     expect( wb.cell(2,2) ).to eq('Richard Washington')
  #     # adds quotes and removes .0 in numbers
  #     # pp wb.to_csv
  #     expect( wb.to_csv ).to eq SpecData::ROO_APPLIED_ENROLLED_CSV_TEXT
  #   end
  #   it "returns the correct xlsx object given a status" do
  #     allow(@oa).to receive(:api_records) { 5 }
  #     status = 'applied'
  #     student_keys  = [:id, :name]
  #     flatten_keys  = [:custom_fields]
  #     reject_keys   = [:parent_guardian]
  #     guardian_info = { count: 1, keys: [:id, :name] }
  #     payment_info  = { count: 1, order: :newest, keys: [:invoice_number, :amount] }
  #     test_answer   = @oa.students_as_xlsx_by_status(status, flatten_keys, reject_keys, student_keys, guardian_info, payment_info)
  #     # # pp test_answer.class
  #     # pp test_answer.is_a? Axlsx::Package
  #     stream = test_answer.to_stream() if test_answer.is_a? Axlsx::Package
  #     # pp stream.is_a? StringIO
  #     # # roo_file = Roo::Excelx.new( stream )
  #     wb = nil
  #     expect{ wb = Roo::Excelx.new(stream) }.to_not raise_error
  #     expect( wb.cell(1,1) ).to eq('student_id')
  #     expect( wb.cell(2,1) ).to eq(95)
  #     expect( wb.cell(2,2) ).to eq('Richard Washington')
  #     # # adds quotes and removes .0 in numbers
  #     # # pp wb.to_csv
  #     expect( wb.to_csv ).to eq SpecData::ROO_APPLIED_CSV_TEXT
  #     # expect( true ).to eq SpecData::ROO_APPLIED_CSV_TEXT
  #   end
  # end

  # context "multiple status axlsx reports" do
  #   it "using multiple statuses return a xlsx object" do
  #     allow(@oa).to receive(:api_records) { 5 }
  #     status = ['applied','enrolled']
  #     student_keys  = [:id, :name]
  #     flatten_keys  = [:custom_fields]
  #     reject_keys   = [:parent_guardian]
  #     guardian_info = { count: 1, keys: [:id, :name] }
  #     payment_info  = { count: 1, order: :newest, keys: [:invoice_number, :amount] }
  #     test_answer   = @oa.students_as_xlsx_by_statuses(status, flatten_keys, reject_keys, student_keys, guardian_info, payment_info)
  #     # pp test_answer.class
  #     # pp test_answer.is_a? Axlsx::Package
  #     stream = test_answer.to_stream() if test_answer.is_a? Axlsx::Package
  #     # roo_file = Roo::Excelx.new( stream )
  #     wb = nil
  #     expect{ wb = Roo::Excelx.new(stream) }.to_not raise_error
  #     expect( wb.cell(1,1) ).to eq('student_id')
  #     expect( wb.cell(2,1) ).to eq(95)
  #     expect( wb.cell(2,2) ).to eq('Richard Washington')
  #     # adds quotes and removes .0 in numbers
  #     # pp wb.to_csv
  #     expect( wb.to_csv ).to eq SpecData::ROO_APPLIED_ENROLLED_CSV_TEXT
  #   end
  # end

  # context "students_as_xlsx_by_status - error gracefully" do
  #   it "when given invalid flatten_keys - non-arrary" do
  #     test_answer = @oa.students_as_xlsx_by_status('applied',:custom_fields,[:parent_guardian])
  #     # pp test_answer
  #     expect( test_answer ).to eq({error: "invalid flatten_keys - need array"})
  #   end
  #   it "when given invalid reject_keys - non-array" do
  #     test_answer = @oa.students_as_xlsx_by_status('applied',[:custom_fields],:parent_guardian)
  #     # pp test_answer
  #     expect( test_answer ).to eq({error: "invalid reject_keys - need array"})
  #   end
  #   it "when given invalid flatten_keys - strings" do
  #     test_answer = @oa.students_as_xlsx_by_status('applied',['custom_fields'],[:parent_guardian])
  #     # pp test_answer
  #     expect( test_answer ).to eq({error: "invalid flatten_keys - use symbols"})
  #   end
  #   it "when given invalid reject_keys - strings" do
  #     test_answer = @oa.students_as_xlsx_by_status('applied',[:custom_fields],['parent_guardian'])
  #     # pp test_answer
  #     expect( test_answer ).to eq({error: "invalid reject_keys - use symbols"})
  #   end
  # end

  # # # DISABLED UNTIL AXLSX works with RubyZip 1.2.1
  # context "students_as_xlsx_by_status handles bad headers - gracefully and errors" do
  #   it "with bad student_keys - not an array" do
  #     test_answer = @oa.students_as_xlsx_by_status([],[],[],:id)
  #     expect( test_answer ).to eq({error: "invalid student_keys - need array"})
  #   end
  #   it "with bad student_keys - uses strings not symbols" do
  #     test_answer = @oa.students_as_xlsx_by_status([],[],[],['id'])
  #     expect( test_answer ).to eq({error: "invalid student_keys - use symbols"})
  #   end
  #   it "with bad guardian_info - not a hash" do
  #     test_answer = @oa.students_as_xlsx_by_status([],[],[],[],:id)
  #     expect( test_answer ).to eq({error: "invalid guardian_info - use hash"})
  #   end
  #   it "with bad guardian_keys - not an array" do
  #     test_answer = @oa.students_as_xlsx_by_status([],[],[],[],{keys: :id})
  #     expect( test_answer ).to eq({error: "invalid guardian_keys - need array"})
  #   end
  #   it "with bad guardian_keys - uses strings not symbols" do
  #     test_answer = @oa.students_as_xlsx_by_status([],[],[],[],{keys: ['id']})
  #     expect( test_answer ).to eq({error: "invalid guardian_keys - use symbols"})
  #   end
  #   it "with bad payment_info - not a hash" do
  #     test_answer = @oa.students_as_xlsx_by_status([],[],[],[],{},:id)
  #     expect( test_answer ).to eq({error: "invalid payment_info - use hash"})
  #   end
  #   it "with bad payment_keys - not an array" do
  #     test_answer = @oa.students_as_xlsx_by_status([],[],[],[],{},{keys: :id})
  #     expect( test_answer ).to eq({error: "invalid payment_keys - need array"})
  #   end
  #   it "with bad payment_keys - uses strings not symbols" do
  #     test_answer = @oa.students_as_xlsx_by_status([],[],[],[],{},{keys: ['id']})
  #     expect( test_answer ).to eq({error: "invalid payment_keys - use symbols"})
  #   end
  # end

end
