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
    it "student_details_by_id - kid 106 w/payments -- as is" do
      test_answer = @oa.student_details_by_id(106)
      # pp test_answer
      expect( test_answer ).to eq SpecData::STUDENT_106_DETAILS_HASH
    end
    it "student_details_by_id - Flatten hash 1 level" do
      test_answer = @oa.student_details_by_id(106,[:custom_fields],[:parent_guardian])
      # pp test_answer
      expect( test_answer ).to eq SpecData::STUDENT_106_FLATTENED_HASH
    end
    xit "student_details_by_id - Flatten array 1 level" do
      test_answer = @oa.student_details_by_id(106,[:custom_fields],[:parent_guardian])
      # pp test_answer
      expect( test_answer ).to eq SpecData::STUDENT_106_FLATTENED_ARRAY
    end
    xit "student_details_by_id - flatten hashes - 2 levels" do
      test_answer = @oa.student_details_by_id(106,[:custom_fields,:custom_fields_signature_of_parent],[:parent_guardian])
      # pp test_answer
      expect( test_answer ).to eq SpecData::STUDENT_106_FLATTENED_2X_HASH
    end
    xit "student_details_by_id - FLATTEN hash or array - 2 levels" do
      test_answer = @oa.student_details_by_id(106,[:custom_fields,:school_list,:custom_fields_signature_of_parent],[:parent_guardian])
      # pp test_answer
      expect( test_answer ).to eq SpecData::STUDENT_106_FLATTENED_2X_HASH_ARRAY
    end
  end
  context "student_details_by_id - error gracefully" do
    it "when given invalid flatten_keys - non-arrary" do
      test_answer = @oa.student_details_by_id(106,:custom_fields,[:parent_guardian])
      # pp test_answer
      expect( test_answer ).to eq({error: "invalid flatten_keys - need array"})
    end
    it "when given invalid reject_keys - non-array" do
      test_answer = @oa.student_details_by_id(106,[:custom_fields],:parent_guardian)
      # pp test_answer
      expect( test_answer ).to eq({error: "invalid reject_keys - need array"})
    end
    it "when given invalid flatten_keys - strings" do
      test_answer = @oa.student_details_by_id(106,['custom_fields'],[:parent_guardian])
      # pp test_answer
      expect( test_answer ).to eq({error: "invalid flatten_keys - use symbols"})
    end
    it "when given invalid reject_keys - strings" do
      test_answer = @oa.student_details_by_id(106,[:custom_fields],['parent_guardian'])
      # pp test_answer
      expect( test_answer ).to eq({error: "invalid reject_keys - use symbols"})
    end
    it "student_details_by_id - kid 95 -- sends back all kid data except payment info" do
      test_answer = @oa.student_details_by_id(106,[],[],false)
      # pp test_answer
      expect( test_answer ).to eq SpecData::STUDENT_106_DETAILS_NO_PAYMENTS_HASH
    end
  end

end