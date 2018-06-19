# require 'json'
require 'spec_helper'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.describe Openapply::GetOneStudent do
  before(:each) do
    @options = {}
    @oa = Openapply::Client.new

    # stub_request(:get, "http://demo.openapply.com/api/v1/students/106?auth_token=demo_site_api_key")
    @url_kid_106  = "#{@oa.api_path}106?auth_token=#{@oa.api_key}"
    stub_request(:get, "#{@oa.api_url}#{@url_kid_106}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_106_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/106/payments?auth_token=demo_site_api_key")
    @url_pay_106  = "#{@oa.api_path}106/payments?auth_token=#{@oa.api_key}"
    stub_request(:get, "#{@oa.api_url}#{@url_pay_106}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_106_PAYMENTS_HASH.to_json)
  end

  context "test API mocks against OpenApply - avoid real api calls" do
    it "oa_api_call - returns correctly formatted billing records 106 - w/data" do
      test_answer = @oa.oa_api_call(@url_pay_106).response.body
      expect( test_answer ).to eq SpecData::STUDENT_106_PAYMENTS_TEXT
    end
    it "oa_api_call - returns correctly formatted student records 106 - complex" do
      test_answer = @oa.oa_api_call(@url_kid_106).response.body
      expect( test_answer ).to eq SpecData::STUDENT_106_RECORD_TEXT
    end
  end

  context "oa_answer - get a single student record or payments" do
    it "oa_answer - returns correctly formatted billing records - no options" do
      # puts @url_pay_95
      expect( @oa.oa_answer(@url_pay_106) ).to eq SpecData::STUDENT_106_PAYMENTS_HASH
    end
    it "oa_answer - returns correct billing object" do
      expect( @oa.oa_answer(@url_pay_106,@options) ).to eq SpecData::STUDENT_106_PAYMENTS_HASH
    end
  end

  context "get individual student info" do
    it "one_student_record_by_id - sends the correct URL to oa_answer" do
      expect(@oa.one_student_record_by_id(106)).to eq SpecData::STUDENT_106_RECORD_HASH
    end
    it "one_student_payments_by_id - sends the correct URL to oa_answer" do
      expect(@oa.one_student_payments_by_id(106)).to eq SpecData::STUDENT_106_PAYMENTS_HASH
    end
  end

  context "join one student record with one student payments" do
    it "one_student_details_by_id - kid 106 w/payments -- as is" do
      test_answer = @oa.one_student_details_by_id(106)
      # pp test_answer
      expect( test_answer ).to eq SpecData::STUDENT_106_DETAILS_HASH
    end
    it "one_student_details_by_id - kid 106 -- sends back all kid data except payment info" do
      # test_answer = @oa.one_student_details_by_id(106,[],[],false)
      test_answer = @oa.one_student_details_by_id(106,{get_payments: false})
      # pp test_answer
      expect( test_answer ).to eq SpecData::STUDENT_106_DETAILS_NO_PAYMENTS_HASH
    end
  end

end
