require "spec_helper"
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.describe Openapply::Client do

  before(:each) do
    allow(ENV).to receive(:[]).with("OA_TIMEOUT").and_return(nil)
    allow(ENV).to receive(:[]).with("OA_DEBUG_HTTP").and_return(false)
    allow(ENV).to receive(:[]).with("OA_RECORD_COUNT").and_return(nil)
    allow(ENV).to receive(:[]).with("OA_BASE_URI").and_return("demo.openapply.com")
    allow(ENV).to receive(:[]).with("OA_CLIENT_ID").and_return("xvz1evFS4wEEPTGEFPHBog")
    allow(ENV).to receive(:[]).with("OA_CLIENT_SECRET").and_return("L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg")

    @options = {}
    @oa = Openapply::Client.new token: "a7bec3a61bdebb406ccc117419cce8713d56403eaeb00ce68397b3a16293a1d3"
  end

  context "basic config - initialization" do
    before(:each) do
      @oa = Openapply::Client.new(
        url: "school.openapply.com",
        client_id: "a1s2d3f4",
        client_secret: "12fhd5wsdf",
        token: "asdfg")
    end

    it "has an url" do
      expect(@oa.api_url).to eq "https://school.openapply.com"
    end

    it "has a client_id " do
      expect(@oa.api_client_id).to eq "a1s2d3f4"
    end

    it "has a client_secret" do
      expect(@oa.api_client_secret).to eq "12fhd5wsdf"
    end

    it "has a token" do
      expect(@oa.api_key).to eq "asdfg"
    end

    it "has debug_http to false" do
      expect(@oa.debug_http).to eq false
    end
  end

  context "basic config - initialization with env" do
    it "has a url" do
      expect(@oa.api_url).to eq "https://demo.openapply.com"
    end

    it "has a client_id" do
      expect(@oa.api_client_id).to eq "xvz1evFS4wEEPTGEFPHBog"
    end

    it "has a client_secret" do
      expect(@oa.api_client_secret).to eq "L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg"
    end

    it "has a custom record_count" do
      allow(ENV).to receive(:[]).with("OA_RECORD_COUNT").and_return("2")
      expect(Openapply::Client.new(token: "123a").api_records).to eq "2"
    end

    xit "trows error w/o a client_id" do
      allow(ENV).to receive(:[]).with("OA_CLIENT_ID").and_return("")
      expect(Openapply::Client.new).to raise_error(ArgumentError)
      expect(Openapply::Client.new).to raise_error('OA_CLIENT_ID is missing')
    end

    xit "trows error w/o a client_secret" do
      allow(ENV).to receive(:[]).with("OA_CLIENT_SECRET").and_return("")
      expect(Openapply::Client.new).to raise_error(ArgumentError)
      expect(Openapply::Client.new).to raise_error('OA_CLIENT_SECRET is missing')
    end
  end

  context "force https" do
    it "force https if http is pass has the uri" do
      allow(ENV).to receive(:[]).with("OA_BASE_URI").and_return("http://oa.com")
      expect(Openapply::Client.new.api_url).to eq "https://oa.com"
    end

    it "does not change the base uri if https is passed" do
      allow(ENV).to receive(:[]).with("OA_BASE_URI").and_return("https://oa.com")
      expect(Openapply::Client.new.api_url).to eq "https://oa.com"
    end

    it "adds the protocol if not included" do
      allow(ENV).to receive(:[]).with("OA_BASE_URI").and_return("oa.com")
      expect(Openapply::Client.new.api_url).to eq "https://oa.com"
    end

    it "force http if https is pass has the uri and debug true" do
      allow(ENV).to receive(:[]).with("OA_BASE_URI").and_return("https://oa.com")
      allow(ENV).to receive(:[]).with("OA_DEBUG_HTTP").and_return(true)
      expect(Openapply::Client.new.api_url).to eq "http://oa.com"
    end

    it "does not change the base uri if http is passed and debug true" do
      allow(ENV).to receive(:[]).with("OA_BASE_URI").and_return("http://oa.com")
      allow(ENV).to receive(:[]).with("OA_DEBUG_HTTP").and_return(true)
      expect(Openapply::Client.new.api_url).to eq "http://oa.com"
    end

    it "adds the protocol if not included and debug true" do
      allow(ENV).to receive(:[]).with("OA_BASE_URI").and_return("oa.com")
      allow(ENV).to receive(:[]).with("OA_DEBUG_HTTP").and_return(true)
      expect(Openapply::Client.new.api_url).to eq "http://oa.com"
    end
  end

  context "default configuration" do
    xit "trows error w/o a url" do
      allow(ENV).to receive(:[]).with("OA_BASE_URI").and_return("")
      expect(Openapply::Client.new).to raise_error(ArgumentError)
      expect(Openapply::Client.new).to raise_error('OA_BASE_URI is missing')
    end

    it "has an api timeout" do
      expect(@oa.api_timeout).not_to be nil
    end

    it "has the correct default base path for API v3" do
      expect(@oa.api_path.to_s).to eq "/api/v3"
    end

    it "has a api_records value" do
      expect(@oa.api_records).not_to be nil
      expect(@oa.api_records).to eq '100'
    end

    # ???
    # it "has a default record return count value greater than 10" do
    #   expect(@oa.api_records.to_i).to eq >= 11
    # end
  end

  context "oa_answer handles code 429 too many request" do
      it "to return a answer after one retry" do
        @url_kid_95  = "#{@oa.api_path}/students/95"
        stub_request(:get, "#{@oa.api_url}#{@url_kid_95}")
              .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
              .to_return( status: 429, headers: {}, body: '{"error": "Rate limit reached. Retry later."}').then
              .to_return( status: 200, headers: {}, body: SpecData::STUDENT_95_RECORD_HASH.to_json)

        test_ans = @oa.one_student_record_by_id(95)
        # pp test_ans
        expect( test_ans ).to eql( SpecData::STUDENT_95_RECORD_HASH )
      end

      it "to return an answer after two retry" do
        @url_kid_95  = "#{@oa.api_path}/students/95"
        stub_request(:get, "#{@oa.api_url}#{@url_kid_95}")
              .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
              .to_return( status: 429, headers: {}, body: '{"error": "Rate limit reached. Retry later."}').then
              .to_return( status: 429, headers: {}, body: '{"error": "Rate limit reached. Retry later."}').then
              .to_return( status: 200, headers: {}, body: SpecData::STUDENT_95_RECORD_HASH.to_json)

        test_ans = @oa.one_student_record_by_id(95)
        # pp test_ans
        expect( test_ans ).to eql( SpecData::STUDENT_95_RECORD_HASH )
      end

      it "to return an answer after three retry" do
        @url_kid_95  = "#{@oa.api_path}/students/95"
        stub_request(:get, "#{@oa.api_url}#{@url_kid_95}")
              .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
              .to_return( status: 429, headers: {}, body: '{"error": "Rate limit reached. Retry later."}').then
              .to_return( status: 429, headers: {}, body: '{"error": "Rate limit reached. Retry later."}').then
              .to_return( status: 429, headers: {}, body: '{"error": "Rate limit reached. Retry later."}').then
              .to_return( status: 200, headers: {}, body: SpecData::STUDENT_95_RECORD_HASH.to_json)

        test_ans = @oa.one_student_record_by_id(95)
        # pp test_ans
        expect( test_ans ).to eql( SpecData::STUDENT_95_RECORD_HASH )
      end

      it "to return an error after four retry" do
        @url_kid_95  = "#{@oa.api_path}/students/95"
        stub_request(:get, "#{@oa.api_url}#{@url_kid_95}")
              .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
              .to_return( status: 429, headers: {}, body: '{"error": "Rate limit reached. Retry later."}').then
              .to_return( status: 429, headers: {}, body: '{"error": "Rate limit reached. Retry later."}').then
              .to_return( status: 429, headers: {}, body: '{"error": "Rate limit reached. Retry later."}').then
              .to_return( status: 429, headers: {}, body: '{"error": "Rate limit reached. Retry later."}')

        test_ans = @oa.one_student_record_by_id(95)
        error_ans = { error: "no response (timeout) from URL: #{@url_kid_95}" }
        expect( test_ans ).to eql( error_ans )
      end
  end

  context "oa_answer handles timeouts" do
    before(:each) do
      # setup api timeout mocks
    end

    it "returns an answer after one timeout" do
      # stub_request(:get, "http://demo.openapply.com/api/v3/students/95")
      @url_kid_95  = "#{@oa.api_path}/students/95"
      stub_request(:get, "#{@oa.api_url}#{@url_kid_95}")
            .to_timeout.times(1).then
            .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
            .to_return( status: 200, headers: {},
                        body: SpecData::STUDENT_95_RECORD_HASH.to_json)
      test_ans = @oa.one_student_record_by_id(95)
      # pp test_ans
      expect( test_ans ).to eql( SpecData::STUDENT_95_RECORD_HASH )
    end

    it "returns an answer after two timeouts" do
      # stub_request(:get, "http://demo.openapply.com/api/v3/students/95")
      @url_kid_95  = "#{@oa.api_path}/students/95"
      stub_request(:get, "#{@oa.api_url}#{@url_kid_95}")
            .to_timeout.times(2).then
            .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
            .to_return( status: 200, headers: {},
                        body: SpecData::STUDENT_95_RECORD_HASH.to_json)
      test_ans = @oa.one_student_record_by_id(95)
      expect( test_ans ).to eql( SpecData::STUDENT_95_RECORD_HASH )
    end

    it "returns an amswer after three timeouts" do
      # stub_request(:get, "http://demo.openapply.com/api/v3/students/95")
      @url_kid_95  = "#{@oa.api_path}/students/95"
      stub_request(:get, "#{@oa.api_url}#{@url_kid_95}")
            .to_timeout.times(3).then
            .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
            .to_return( status: 200, headers: {},
                        body: SpecData::STUDENT_95_RECORD_HASH.to_json)
      test_ans  = @oa.one_student_record_by_id(95)
      # error_ans = { error: "SITE TIMEOUT - 3 Consecutive FAILURES"  }
      expect( test_ans ).to eql( SpecData::STUDENT_95_RECORD_HASH )
    end

    it "returns an error after four timeouts" do
      # stub_request(:get, "http://demo.openapply.com/api/v3/students/95")
      @url_kid_95  = "#{@oa.api_path}/students/95"
      stub_request(:get, "#{@oa.api_url}#{@url_kid_95}")
            .to_timeout.times(4).then
            .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
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
  end

  context "authentification using oauth2" do
    it "returns a token using client id & secret" do
      allow(ENV).to receive(:[]).with("https_proxy").and_return(nil)
      allow(ENV).to receive(:[]).with("HTTPS_PROXY").and_return(nil)
      allow(ENV).to receive(:[]).with("OAUTH_DEBUG").and_return(true)

      stub_auth(@oa.api_url)

      expect(@oa.authentificate).to be_a_kind_of(OAuth2::AccessToken)
      expect(@oa.authentificate.token).to eq("a7bec3a61bdebb406ccc117419cce8713d56403eaeb00ce68397b3a16293a1d3")
      expect(@oa.authentificate.expires_in).to eq(2629745)
    end
  end

end
