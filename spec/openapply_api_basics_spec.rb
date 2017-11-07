require "spec_helper"
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.describe Openapply do

  before(:each) do
    @options = {}
    @oa = Openapply::Client.new
  end

  context "basic config - initialization" do
    it "has a version number" do
      expect(Openapply::VERSION).not_to be nil
    end
    it "has correct version number" do
      expect(Openapply::VERSION).to eq "0.2.1"
    end
    it "has a url" do
      expect(@oa.api_url).not_to be nil
      expect(@oa.api_url).to eq 'demo.openapply.com'
    end
    it "has an Auth key" do
      expect(@oa.api_key).not_to be nil
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

    it "returns an answer after one timeout"
    it "returns an aswer after two timeouts"
    it "returns an error after three timeouts"
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
