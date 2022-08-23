# require 'json'
require 'spec_helper'
require 'webmock/rspec'
require 'json'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.describe Openapply::GetOneStudent do
  before(:each) do
    allow(ENV).to receive(:[]).with("OA_TIMEOUT").and_return(nil)
    allow(ENV).to receive(:[]).with("OA_DEBUG_HTTP").and_return(false)
    allow(ENV).to receive(:[]).with("OA_RECORD_COUNT").and_return(nil)
    allow(ENV).to receive(:[]).with("OA_BASE_URI").and_return("demo.openapply.com")
    allow(ENV).to receive(:[]).with("OA_CLIENT_ID").and_return("xvz1evFS4wEEPTGEFPHBog")
    allow(ENV).to receive(:[]).with("OA_CLIENT_SECRET").and_return("L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg")

    @options = {}
    @oa = Openapply::Client.new token: "a7bec3a61bdebb406ccc117419cce8713d56403eaeb00ce68397b3a16293a1d3"

    # stub_request(:put, "http://demo.openapply.com/api/v1/students/106")
    @url_put_id_kid_106  = "#{@oa.api_path}/students/106"
    stub_request(:put, "#{@oa.api_url}#{@url_put_id_kid_106}")
          .with(body: {student_id: 123456})
          .with(headers: { 'Content-Type' => 'application/x-www-form-urlencoded; charset=utf-8', "Authorization" => "Bearer " + @oa.api_key} )
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_106_PUT_RESPONSE_HASH.to_json)
  end

  context "test API mocks against OpenApply - avoid real api calls" do
    it "oa_api_call - returns correctly formatted student records 106 - complex" do
      test_answer = @oa.put(@url_put_id_kid_106, {student_id: 123456} ).response.body
      expect( test_answer ).to eq SpecData::STUDENT_106_PUT_RESPONSE_HASH.to_json
    end
  end

end
