# require 'json'
require 'spec_helper'
require 'webmock/rspec'
require 'json'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.describe Openapply::GetOneStudent do
  before(:each) do
    @options = {}
    @oa = Openapply::Client.new

    # stub_request(:get, "http://demo.openapply.com/api/v1/students/106?auth_token=demo_site_api_key")
    # @url_kid_106  = "#{@oa.api_path}106?auth_token=#{@oa.api_key}"
    @url_put_id_kid_106  = "#{@oa.api_path}106"
    stub_request(:put, "http://#{@oa.api_url}#{@url_put_id_kid_106}")
          .with(query: {auth_token: @oa.api_key, student_id: 123456})
          .with(headers: { 'Content-Type' => 'application/x-www-form-urlencoded; charset=utf-8'} )
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_106_PUT_RESPONSE_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v1/students/106/payments?auth_token=demo_site_api_key")
    # @url_pay_106  = "#{@oa.api_path}106/payments?auth_token=#{@oa.api_key}"
    # stub_request(:get, "http://#{@oa.api_url}#{@url_pay_106}")
    #       .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
    #       .to_return( status: 200, headers: {},
    #                   body: SpecData::STUDENT_106_PAYMENTS_HASH.to_json)
  end

  context "test API mocks against OpenApply - avoid real api calls" do
    it "oa_api_call - returns correctly formatted student records 106 - complex" do
      test_answer = @oa.put(@url_put_id_kid_106, {student_id: 123456} ).response.body
      expect( test_answer ).to eq SpecData::STUDENT_106_PUT_RESPONSE_HASH.to_json
    end
  end

end
