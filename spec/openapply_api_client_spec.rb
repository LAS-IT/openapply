require "spec_helper"
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.describe Openapply::Client do

  before(:each) do
    @options = {}
    @oa = Openapply::Client.new
  end

  context "basic config - initialization" do
    it "has a url" do
      expect(@oa.api_url).not_to be nil
      # expect(@oa.api_url).to eq 'demo.openapply.com'
    end
    xit "trows error w/o a url" do
      allow(ENV).to receive(:[]).with("OA_BASE_URI").and_return("")
      expect(Openapply::Client.new).to raise_error(ArgumentError)
      expect(Openapply::Client.new).to raise_error('OA_BASE_URI is missing')
      # expect Openapply::Client.new.to raise_error(ArgumentError, 'OA_BASE_URI is missing')
      # expect(@oa.api_url).to eq 'demo.openapply.com'
    end
    it "has an Auth key" do
      expect(@oa.api_key).not_to be nil
    end
    xit "trows error w/o a key" do
      allow(ENV).to receive(:[]).with("OA_AUTH_TOKEN").and_return("")
      expect(Openapply::Client.new).to raise_error(ArgumentError)
      expect(Openapply::Client.new).to raise_error('OA_AUTH_TOKEN is missing')
      # expect Openapply::Client.new.to raise_error(ArgumentError, 'OA_BASE_URI is missing')
      # expect(@oa.api_url).to eq 'demo.openapply.com'
    end
    it "has an base path" do
      expect(@oa.api_path).not_to be nil
      expect(@oa.api_path).to eq '/api/v1/students/'
    end
    it "has an api timeout" do
      expect(@oa.api_timeout).not_to be nil
    end
    it "has the correct default base path for API v1" do
      # puts "Base: #{@oa.api_path}"
      expect(@oa.api_path.to_s).to be == "/api/v1/students/"
    end
    it "has a api_records value" do
      expect(@oa.api_records).not_to be nil
    end
    it "has a default record return count value greater than 10" do
      # puts "Base: #{@oa.api_records}"
      expect(@oa.api_records.to_i).to be >= 11
    end
  end

  context "oa_answer handles timeouts" do
    before(:each) do
      # setup api timeout mocks
    end

    it "returns an answer after one timeout" do
      # stub_request(:get, "http://demo.openapply.com/api/v1/students/95?auth_token=demo_site_api_key")
      @url_kid_95  = "#{@oa.api_path}95?auth_token=#{@oa.api_key}"
      stub_request(:get, "http://#{@oa.api_url}#{@url_kid_95}")
            .to_timeout.times(1).then
            .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
            .to_return( status: 200, headers: {},
                        body: SpecData::STUDENT_95_RECORD_HASH.to_json)
      test_ans = @oa.one_student_record_by_id(95)
      # pp test_ans
      expect( test_ans ).to eql( SpecData::STUDENT_95_RECORD_HASH )
    end
    it "returns an answer after two timeouts" do
      # stub_request(:get, "http://demo.openapply.com/api/v1/students/95?auth_token=demo_site_api_key")
      @url_kid_95  = "#{@oa.api_path}95?auth_token=#{@oa.api_key}"
      stub_request(:get, "http://#{@oa.api_url}#{@url_kid_95}")
            .to_timeout.times(2).then
            .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
            .to_return( status: 200, headers: {},
                        body: SpecData::STUDENT_95_RECORD_HASH.to_json)
      test_ans = @oa.one_student_record_by_id(95)
      expect( test_ans ).to eql( SpecData::STUDENT_95_RECORD_HASH )
    end
    it "returns an error after three timeouts" do
      # stub_request(:get, "http://demo.openapply.com/api/v1/students/95?auth_token=demo_site_api_key")
      @url_kid_95  = "#{@oa.api_path}95?auth_token=#{@oa.api_key}"
      stub_request(:get, "http://#{@oa.api_url}#{@url_kid_95}")
            .to_timeout.times(3).then
            .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
            .to_return( status: 200, headers: {},
                        body: SpecData::STUDENT_95_RECORD_HASH.to_json)
      test_ans  = @oa.one_student_record_by_id(95)
      # error_ans = { error: "SITE TIMEOUT - 3 Consecutive FAILURES"  }
      expect( test_ans ).to eql( SpecData::STUDENT_95_RECORD_HASH )
    end
    it "returns an error after three timeouts" do
      # stub_request(:get, "http://demo.openapply.com/api/v1/students/95?auth_token=demo_site_api_key")
      @url_kid_95  = "#{@oa.api_path}95?auth_token=#{@oa.api_key}"
      stub_request(:get, "http://#{@oa.api_url}#{@url_kid_95}")
            .to_timeout.times(4).then
            .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
            .to_return( status: 200, headers: {},
                        body: SpecData::STUDENT_95_RECORD_HASH.to_json)
      test_ans  = @oa.one_student_record_by_id(95)
      error_ans = { error: "no response (timeout) from URL: #{@url_kid_95}" }
      expect( test_ans ).to eql( error_ans )
    end
  end

  context "oa_answer - test invalid url conditions" do
    it "oa_answer - returns the proper error message when given a blank url" do
      expect( @oa.oa_answer("") ).to eql( { error: 'no url given' } )
    end
    it "oa_answer - returns the proper error message when url has spaces" do
      expect( @oa.oa_answer("humpty dumpty") ).to eql( { error: 'bad url - has space' } )
    end
    it "oa_answer - returns the proper error message when base path is missing/wrong" do
      expect( @oa.oa_answer("humpty") ).to eql( { error: 'bad api_path' } )
    end
    it "oa_answer - returns the proper error message when auth_token is missing/wrong" do
      expect( @oa.oa_answer("#{@oa.api_path}?auth_token=xyz") ).to eql( { error: 'bad auth_token' } )
    end
  end

end
