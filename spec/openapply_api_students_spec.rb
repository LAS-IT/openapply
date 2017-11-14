# require 'json'
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


  context "test API mocks against OpenApply - avoid real api calls" do
    it "oa_api_call - returns correctly formatted billing records 95 - blank" do
      test_answer = @oa.oa_api_call(@url_pay_95).response.body
      expect( test_answer ).to eq SpecData::STUDENT_95_PAYMENTS_TEXT
    end

    it "oa_api_call - returns correctly formatted billing records 106 - w/data" do
      test_answer = @oa.oa_api_call(@url_pay_106).response.body
      expect( test_answer ).to eq SpecData::STUDENT_106_PAYMENTS_TEXT
    end

    it "oa_api_call - returns correctly formatted student records 95 - complex" do
      test_answer = @oa.oa_api_call(@url_kid_95).response.body
      expect( test_answer ).to eq SpecData::STUDENT_95_RECORD_TEXT
    end

    it "oa_api_call - returns correctly formatted student records 106 - complex" do
      test_answer = @oa.oa_api_call(@url_kid_106).response.body
      expect( test_answer ).to eq SpecData::STUDENT_106_RECORD_TEXT
    end

  end

  # TODO: test timeout behavior
  context "oa_answer / timeout - handles 1/2 timeouts - not 3"


  context "oa_answer - get a single student record or payments" do
    it "oa_answer - returns correctly formatted billing records - no options" do
      # puts @url_pay_95
      expect( @oa.oa_answer(@url_pay_95) ).to eq SpecData::STUDENT_95_PAYMENTS_HASH
    end
    it "oa_answer - returns correct billing values" do
      expect(@oa.oa_answer(@url_pay_95)[:payments].empty?).to be true
    end
    it "oa_answer - returns correct billing object" do
      expect( @oa.oa_answer(@url_pay_95,@options) ).to eq SpecData::STUDENT_95_PAYMENTS_HASH
    end

    it "payments_by_id - sends the correct URL to oa_answer" do
      expect(@oa.payments_by_id(95)).to eq SpecData::STUDENT_95_PAYMENTS_HASH
    end
    it "payments_by_id - sends the correct URL to oa_answer" do
      expect(@oa.payments_by_id(106)).to eq SpecData::STUDENT_106_PAYMENTS_HASH
    end

    it "student_by_id - sends the correct URL to oa_answer" do
      expect(@oa.student_by_id(95)).to eq SpecData::STUDENT_95_RECORD_HASH
    end
    it "student_by_id - sends the correct URL to oa_answer" do
      expect(@oa.student_by_id(106)).to eq SpecData::STUDENT_106_RECORD_HASH
    end
  end

  context "join one student record with one student payments" do
    it "student_details_by_id - sends back all info on a given student in ONE hash" do
      # pp @oa.student_details_by_id(95)
      expect(@oa.student_details_by_id(95)).to eq SpecData::STUDENT_95_ALL_DATA_HASH
    end
    it "student_details_by_id - sends back all info on a given student in ONE hash" do
      # pp @oa.student_details_by_id(106)
      expect(@oa.student_details_by_id(106)).to eq SpecData::STUDENT_106_ALL_DATA_HASH
    end
  end

  context "test the custom summary (non-recursive) api call" do
    it "gets first 3 records of status 'applied' with ids larger than '240'"
    # @answer = @oa.custom_student_summaries('applied',240,nil,3)
    it "gets first 3 records of status 'applied' with updates after '2015-09-12'"
    # @answer = @oa.custom_student_summaries('applied',nil,'2015-09-12',3)
  end

  context "test the student summary api call" do
    before(:each) do
      allow(@oa).to receive(:api_records) { 3 }
    end

    # https://demo.openapply.com//api/v1/students?status=applied&count=3&auth_token=demo_site_api_key
    it "oa_api_call - get the first page students who are in applied" do
      test_answer = @oa.oa_api_call(@url_status_summary_p_1).response.body
      expect(test_answer).to eq SpecData::STATUS_APPLIED_PAGE_1_TEXT
    end
    # https://demo.openapply.com//api/v1/students?status=applied&since_id=240&count=3&auth_token=demo_site_api_key
    it "oa_api_call - get the second page students who are in applied" do
      test_answer = @oa.oa_api_call(@url_status_summary_p_2).response.body
      expect(test_answer).to eq SpecData::STATUS_APPLIED_PAGE_2_TEXT
    end
    # # https://demo.openapply.com//api/v1/students?status=applied&since_id=269&count=3&auth_token=demo_site_api_key
    it "oa_api_call - get the last page of students who are in applied" do
      test_answer = @oa.oa_api_call(@url_status_summary_p_3).response.body
      expect(test_answer).to eq SpecData::STATUS_APPLIED_PAGE_3_TEXT
    end

  end

  context "find all students with api - even with multiple pages" do
    before(:each) do
      @correct_ids = [95, 106, 240, 267, 268, 269, 270, 271]
    end
    it "can query for a single page of student summaries" do
      allow(@oa).to receive(:api_records) { 10 }
      test_answer = @oa.students_by_status('applied')
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_PAGES_ALL_HASH
    end
    it "gets all pages when of a given status" do
      allow(@oa).to receive(:api_records) { 3 }
      test_answer = @oa.students_by_status('applied')
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_COLLECTED_HASH
    end
    it "correctly makes a student ids of a given status - from a single pages" do
      allow(@oa).to receive(:api_records) { 10 }
      test_ids = @oa.all_student_ids_by_status('applied')
      expect( test_ids ).to eq ( { student_ids: @correct_ids } )
    end
    it "correctly makes a student ids of a given status - from multiple pages" do
      allow(@oa).to receive(:api_records) { 3 }
      test_ids = @oa.all_student_ids_by_status('applied')
      expect( test_ids ).to eq ( { student_ids: @correct_ids } )
    end
    it "finds all student data on all students of a status" do
      allow(@oa).to receive(:api_records) { 10 }
      test_answer = @oa.students_details_by_status('applied')
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_ALL_DETAILS_HASH
    end
    it "finds all student data on all students of a status and flattens the data" do
      allow(@oa).to receive(:api_records) { 10 }
      test_answer = @oa.students_details_by_status('applied',[:custom_fields],[:parent_guardian])
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_ALL_FLATTENED_HASH
    end
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
    xit "convert an array of students_details into a csv string object" do
      allow(@oa).to receive(:api_records) { 10 }
      student_array = []
      test_answer = @oa.students_array_to_csv(student_array)
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_CSV
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

  context "build correct urls for students summary queries" do
    let(:correct_answer) { "#{@oa.api_path}?#{@placeholder}count=#{@oa.api_records}&auth_token=#{@oa.api_key}" }

    it "builds a correct url with NO parameters" do
      @placeholder = nil
      test_answer  = @oa.students_query_url()
      expect( test_answer ).to eq correct_answer
    end
    it "builds a correct url based on date" do
      # format: YYYY-MM-DD -- not yet 2013-09-25 02:10:39
      since_date   = Date.today - 2
      @placeholder = "since_date=#{since_date}&"
      test_answer  = @oa.students_query_url(nil,nil,since_date)
      expect( test_answer ).to eq correct_answer
    end
    it "builds a correct url based on status" do
      status       = 'applied'
      @placeholder = "status=#{status}&"
      test_answer  = @oa.students_query_url(status)
      expect( test_answer ).to eq correct_answer
    end
    it "builds a correct url based on status & since_id" do
      status       = 'applied'
      since_id     = '95'
      @placeholder = "status=#{status}&since_id=#{since_id}&"
      test_answer  = @oa.students_query_url(status,since_id)
      expect( test_answer ).to eq correct_answer
    end
    it "builds a correct url based on status & date" do
      status       = 'applied'
      since_date   = '2017-11-01'
      @placeholder = "status=#{status}&since_date=#{since_date}&"
      test_answer  = @oa.students_query_url(status,nil,since_date)
      expect( test_answer ).to eq correct_answer
    end
    it "builds a correct url based on status & date" do
      status       = 'applied'
      since_id     = '95'
      since_date   = '2017-11-01'
      @placeholder = "status=#{status}&since_id=#{since_id}&since_date=#{since_date}&"
      test_answer  = @oa.students_query_url(status,since_id,since_date)
      expect( test_answer ).to eq correct_answer
    end
  end

end
