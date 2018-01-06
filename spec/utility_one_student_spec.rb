# require 'json'
require 'spec_helper'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.describe Openapply do
  before(:each) do
    @options = {}
    @oa = Openapply::Client.new

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

  # xcontext "one_student_flattened_details_by_id" do
  #   xit "one_student_flattened_details_by_id - Flatten hash 1 level" do
  #     test_answer = @oa.student_details_by_id(106,[:custom_fields],[:parent_guardian])
  #     # pp test_answer
  #     expect( test_answer ).to eq SpecData::STUDENT_106_FLATTENED_HASH
  #   end
  #   xit "student_details_by_id - Flatten array 1 level" do
  #     test_answer = @oa.student_details_by_id(106,[:custom_fields],[:parent_guardian])
  #     # pp test_answer
  #     expect( test_answer ).to eq SpecData::STUDENT_106_FLATTENED_ARRAY
  #   end
  #   xit "student_details_by_id - flatten hashes - 2 levels" do
  #     test_answer = @oa.student_details_by_id(106,[:custom_fields,:custom_fields_signature_of_parent],[:parent_guardian])
  #     # pp test_answer
  #     expect( test_answer ).to eq SpecData::STUDENT_106_FLATTENED_2X_HASH
  #   end
  #   xit "student_details_by_id - FLATTEN hash or array - 2 levels" do
  #     test_answer = @oa.student_details_by_id(106,[:custom_fields,:school_list,:custom_fields_signature_of_parent],[:parent_guardian])
  #     # pp test_answer
  #     expect( test_answer ).to eq SpecData::STUDENT_106_FLATTENED_2X_HASH_ARRAY
  #   end
  # end
  # xcontext "student_details_by_id - error gracefully" do
  #   xit "when given invalid flatten_keys - non-arrary" do
  #     test_answer = @oa.student_details_by_id(106, {flatten_keys: :custom_fields,
  #                                                   reject_keys: [:parent_guardian]})
  #     # pp test_answer
  #     expect( test_answer ).to eq({error: "invalid flatten_keys - need array"})
  #   end
  #   xit "when given invalid reject_keys - non-array" do
  #     # test_answer = @oa.student_details_by_id(106,[:custom_fields],:parent_guardian)
  #     test_answer = @oa.student_details_by_id(106, {flatten_keys: [:custom_fields],
  #                                                   reject_keys: :parent_guardian})
  #     # pp test_answer
  #     expect( test_answer ).to eq({error: "invalid reject_keys - need array"})
  #   end
  #   xit "when given invalid flatten_keys - strings" do
  #     # test_answer = @oa.student_details_by_id(106,['custom_fields'],[:parent_guardian])
  #     test_answer = @oa.student_details_by_id(106,{ flatten_keys: ['custom_fields'],
  #                                                   reject_keys: [:parent_guardian]})
  #     # pp test_answer
  #     expect( test_answer ).to eq({error: "invalid flatten_keys - use symbols"})
  #   end
  #   xit "when given invalid reject_keys - strings" do
  #     # test_answer = @oa.student_details_by_id(106,[:custom_fields],['parent_guardian'])
  #     test_answer = @oa.student_details_by_id(106, {flatten_keys: [:custom_fields],
  #                                                   reject_keys: ['parent_guardian']})
  #     # pp test_answer
  #     expect( test_answer ).to eq({error: "invalid reject_keys - use symbols"})
  #   end
  # end

end
