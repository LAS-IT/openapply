require 'csv'
require 'spec_helper'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.describe Openapply do
  before(:each) do
    @options = {}
    @oa = Openapply::Client.new

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
    # https://demo.openapply.com/api/v1/students/?status=applied&count=10&auth_token=demo_site_api_key
    @url_status_summary_8 = "#{@oa.api_path}?status=applied&count=10&auth_token=#{ @oa.api_key }"
    stub_request(:get, "http://#{@oa.api_url}#{@url_status_summary_8}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STATUS_APPLIED_PAGES_ALL_HASH.to_json)
  end

  context "data conversions" do
    it "convert a empty hash of students_details into an array - no keys" do
      # allow(@oa).to receive(:api_records) { 10 }
      student_hash = {}
      test_answer = @oa.students_hash_to_array(student_hash)
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_ARRAY_EMPTY
    end
    it "convert a empty hash of students_details into an array" do
      # allow(@oa).to receive(:api_records) { 10 }
      student_keys = [:id, :name]
      students_hash = {}
      test_answer = @oa.students_hash_to_array(students_hash, student_keys)
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_ARRAY_KIDS_EMPTY
    end
    it "convert a empty hash of students_details into an array with 2 guardian headers" do
      # allow(@oa).to receive(:api_records) { 10 }
      student_keys = [:id, :name]
      # get first two parents
      guardian_keys = { count: 2, keys: [:id, :name] }
      student_hash = {}
      test_answer = @oa.students_hash_to_array(student_hash, student_keys, guardian_keys)
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_ARRAY_KIDS_RENTS_EMPTY
    end
    it "convert a empty hash of students_details into an array with 2 payment headers" do
      # allow(@oa).to receive(:api_records) { 10 }
      student_keys = [:id, :name]
      # get max number of parent records
      payment_keys = { count: 2, keys: [:invoice_number, :amount] }
      student_hash = {}
      test_answer = @oa.students_hash_to_array(student_hash, student_keys, nil, payment_keys)
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_ARRAY_KIDS_PAY_EMPTY
    end
    it "convert a empty hash of students_details into an array wo kid keys, but guardian and payment keys" do
      # allow(@oa).to receive(:api_records) { 10 }
      # student_keys = [:id, :name]
      guardian_keys = { count: 2, keys: [:id, :name] }
      payment_keys  = { count: 2, order: :oldest, keys: [:invoice_number, :amount] }
      student_hash = {}
      test_answer = @oa.students_hash_to_array(student_hash, nil, guardian_keys, payment_keys)
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_ARRAY_KIDS_KEYS_EMPTY
    end
    it "convert a hash of students_details into an array - just kid names" do
      # allow(@oa).to receive(:api_records) { 10 }
      student_keys  = [:id, :name]
      # guardian_keys = { count: 1, keys: [:id, :name] }
      # payment_keys  = { count: 2, order: :newest, keys: [:invoice_number, :amount] }
      student_hash  = SpecData::STATUS_APPLIED_ALL_DETAILS_HASH
      test_answer = @oa.students_hash_to_array(student_hash, student_keys)
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_ARRAY_POPULATED_KIDS
    end
    it "convert a hash of students_details into an array - w kid names & ONE parent name" do
      # allow(@oa).to receive(:api_records) { 10 }
      student_keys  = [:id, :name]
      guardian_keys = { count: 1, keys: [:id, :name] }
      # payment_keys  = { count: 2, order: :newest, keys: [:invoice_number, :amount] }
      student_hash  = SpecData::STATUS_APPLIED_ALL_FLATTENED_HASH
      test_answer   = @oa.students_hash_to_array(student_hash, student_keys, guardian_keys)
      true_answer   = SpecData::STATUS_APPLIED_ARRAY_POPULATED_KIDS_1_GUARDIAN
      # pp test_answer
      expect( test_answer ).to eq true_answer
    end
    it "convert a hash of students_details into an array - w kid names & TWO parent records" do
      # allow(@oa).to receive(:api_records) { 10 }
      student_keys  = [:id, :name]
      guardian_keys = { count: 2, keys: [:id, :name] }
      # payment_keys  = { count: 2, order: :newest, keys: [:invoice_number, :amount] }
      student_hash  = SpecData::STATUS_APPLIED_ALL_FLATTENED_HASH
      test_answer   = @oa.students_hash_to_array(student_hash, student_keys, guardian_keys)
      true_answer   = SpecData::STATUS_APPLIED_ARRAY_POPULATED_KIDS_2_GUARDIANS
      # pp test_answer
      expect( test_answer ).to eq true_answer
    end
    it "convert a hash of students_details into an array - w kid names & ONE NEWEST payment implied" do
      # allow(@oa).to receive(:api_records) { 10 }
      student_keys  = [:id, :name]
      # guardian_keys = { count: 1, keys: [:id, :name] }
      payment_keys  = { count: 1, keys: [:invoice_number, :amount] }
      student_hash  = SpecData::STATUS_APPLIED_ALL_FLATTENED_HASH
      test_answer   = @oa.students_hash_to_array(student_hash, student_keys, nil, payment_keys)
      true_answer   = SpecData::STATUS_APPLIED_ARRAY_POPULATED_KIDS_LAST_PAYMENT
      # pp test_answer
      expect( test_answer ).to eq true_answer
    end
    it "convert a hash of students_details into an array - w kid names & ONE NEWEST payment - explicit" do
      # allow(@oa).to receive(:api_records) { 10 }
      student_keys  = [:id, :name]
      # guardian_keys = { count: 1, keys: [:id, :name] }
      payment_keys  = { count: 1, order: :newest, keys: [:invoice_number, :amount] }
      student_hash  = SpecData::STATUS_APPLIED_ALL_FLATTENED_HASH
      test_answer   = @oa.students_hash_to_array(student_hash, student_keys, nil, payment_keys)
      true_answer   = SpecData::STATUS_APPLIED_ARRAY_POPULATED_KIDS_LAST_PAYMENT
      # pp test_answer
      expect( test_answer ).to eq true_answer
    end
    it "convert a hash of students_details into an array - w kid names & LAST TWO NEWEST payments" do
      # allow(@oa).to receive(:api_records) { 10 }
      student_keys  = [:id, :name]
      # guardian_keys = { count: 1, keys: [:id, :name] }
      payment_keys  = { count: 2, order: :newest, keys: [:invoice_number, :amount] }
      student_hash  = SpecData::STATUS_APPLIED_ALL_FLATTENED_MULTI_PAYMENTS_HASH
      test_answer   = @oa.students_hash_to_array(student_hash, student_keys, nil, payment_keys)
      true_answer   = SpecData::STATUS_APPLIED_ARRAY_POPULATED_KIDS_NEWEST_PAYMENTS
      # pp test_answer
      expect( test_answer ).to eq true_answer
    end
    it "convert a hash of students_details into an array - w kid names & TWO OLDEST payments" do
      # allow(@oa).to receive(:api_records) { 10 }
      student_keys  = [:id, :name]
      # guardian_keys = { count: 1, keys: [:id, :name] }
      payment_keys  = { count: 2, order: :oldest, keys: [:invoice_number, :amount] }
      student_hash  = SpecData::STATUS_APPLIED_ALL_FLATTENED_MULTI_PAYMENTS_HASH
      test_answer   = @oa.students_hash_to_array(student_hash, student_keys, nil, payment_keys)
      true_answer   = SpecData::STATUS_APPLIED_ARRAY_POPULATED_KIDS_OLDEST_PAYMENTS
      # pp test_answer
      expect( test_answer ).to eq true_answer
    end
    it "convert a hash of students_details into an array - w KID & PARENT & PAYMENTS" do
      # allow(@oa).to receive(:api_records) { 10 }
      student_keys  = [:id, :name]
      guardian_keys = { count: 1, keys: [:id, :name] }
      payment_keys  = { count: 1, order: :newest, keys: [:invoice_number, :amount] }
      student_hash  = SpecData::STATUS_APPLIED_ALL_FLATTENED_HASH
      test_answer   = @oa.students_hash_to_array(student_hash, student_keys, guardian_keys, payment_keys)
      true_answer   = SpecData::STATUS_APPLIED_ARRAY_POPULATED_KIDS_GUARDIAN_PAYMENT
      # pp test_answer
      expect( test_answer ).to eq true_answer
    end
    it "convert an array of students_details into a csv string object" do
      # allow(@oa).to receive(:api_records) { 10 }
      student_array = SpecData::STATUS_APPLIED_ARRAY_POPULATED_KIDS_GUARDIAN_PAYMENT
      test_answer   = @oa.students_array_to_csv(student_array)
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_CSV_TEXT
    end
    it "using a status return an array object" do
      allow(@oa).to receive(:api_records) { 10 }
      status = 'applied'
      student_keys  = [:id, :name]
      flatten_keys  = [:custom_fields]
      reject_keys   = [:parent_guardian]
      guardian_keys = { count: 1, keys: [:id, :name] }
      payment_keys  = { count: 1, order: :newest, keys: [:invoice_number, :amount] }
      test_answer   = @oa.students_as_array_by_status(status, flatten_keys, reject_keys, student_keys, guardian_keys, payment_keys)
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_ARRAY_POPULATED_KIDS_GUARDIAN_PAYMENT
    end
    it "using a status return a csv string" do
      allow(@oa).to receive(:api_records) { 10 }
      status = 'applied'
      student_keys  = [:id, :name]
      flatten_keys  = [:custom_fields]
      reject_keys   = [:parent_guardian]
      guardian_keys = { count: 1, keys: [:id, :name] }
      payment_keys  = { count: 1, order: :newest, keys: [:invoice_number, :amount] }
      test_answer   = @oa.students_as_csv_by_status(status, flatten_keys, reject_keys, student_keys, guardian_keys, payment_keys)
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_CSV_TEXT
    end
    xit "convert an array of students_details into a xlsx string object" do
      allow(@oa).to receive(:api_records) { 10 }
      student_array = []
      test_answer = @oa.students_array_to_xlsx(student_array)
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_XLSX
    end
    xit "convert a has of students_details into a csv string object" do
      allow(@oa).to receive(:api_records) { 10 }
      student_hash = {}
      test_answer = @oa.students_details_to_csv(student_hash)
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_CSV
    end
    xit "convert a has of students_details into a xlsx string object" do
      allow(@oa).to receive(:api_records) { 10 }
      student_hash = {}
      test_answer = @oa.students_details_to_xlsx(student_hash)
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_XLSX
    end
    xit "collect multiple statuses into a single student details hash" do
      allow(@oa).to receive(:api_records) { 10 }
      test_answer = @oa.students_details_by_statuses(['applied','accepted'])
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_CSV
    end
  end

end
