# require 'json'
require 'spec_helper'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.describe Openapply::GetOneStudent do
  before(:each) do
    allow(ENV).to receive(:[]).with("OA_TIMEOUT").and_return(nil)
    allow(ENV).to receive(:[]).with("OA_RECORD_COUNT").and_return(nil)
    allow(ENV).to receive(:[]).with("OA_DEBUG").and_return(false)
    allow(ENV).to receive(:[]).with("OA_BASE_URI").and_return("demo.openapply.com")
    allow(ENV).to receive(:[]).with("OA_CLIENT_ID").and_return("xvz1evFS4wEEPTGEFPHBog")
    allow(ENV).to receive(:[]).with("OA_CLIENT_SECRET").and_return("L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg")

    @options = {}
    @oa = Openapply::Client.new token: "a7bec3a61bdebb406ccc117419cce8713d56403eaeb00ce68397b3a16293a1d3"

    # stub_request(:get, "http://demo.openapply.com/api/v3/students/106)
    @url_kid_106  = "#{@oa.api_path}/students/106"
    stub_request(:get, "#{@oa.api_url}#{@url_kid_106}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_106_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/106/payments)
    @url_pay_106  = "#{@oa.api_path}/students/106/payments"
    stub_request(:get, "#{@oa.api_url}#{@url_pay_106}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
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
