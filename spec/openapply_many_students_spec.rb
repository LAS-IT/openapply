require 'spec_helper'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.describe Openapply::GetManyStudents do
  before(:each) do
    allow(ENV).to receive(:[]).with("OA_TIMEOUT").and_return(nil)
    allow(ENV).to receive(:[]).with("OA_RECORD_COUNT").and_return(nil)
    allow(ENV).to receive(:[]).with("OA_DEBUG").and_return(false)
    allow(ENV).to receive(:[]).with("OA_BASE_URI").and_return("demo.openapply.com")
    allow(ENV).to receive(:[]).with("OA_CLIENT_ID").and_return("xvz1evFS4wEEPTGEFPHBog")
    allow(ENV).to receive(:[]).with("OA_CLIENT_SECRET").and_return("L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg")

    @options = {}
    @oa = Openapply::Client.new token: "a7bec3a61bdebb406ccc117419cce8713d56403eaeb00ce68397b3a16293a1d3"

    # stub_request(:get, "http://demo.openapply.com/api/v3/students/1)
    @url_kid_1  = "#{@oa.api_path}/students/1"
    stub_request(:get, "#{@oa.api_url}#{@url_kid_1}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_1_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/1/payments)
    @url_pay_1  = "#{@oa.api_path}/students/1/payments"
    stub_request(:get, "#{@oa.api_url}#{@url_pay_1}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_1_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/4)
    @url_kid_4  = "#{@oa.api_path}/students/4"
    stub_request(:get, "#{@oa.api_url}#{@url_kid_4}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_4_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/4/payments)
    @url_pay_4  = "#{@oa.api_path}/students/4/payments"
    stub_request(:get, "#{@oa.api_url}#{@url_pay_4}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_4_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/5)
    @url_kid_5  = "#{@oa.api_path}/students/5"
    stub_request(:get, "#{@oa.api_url}#{@url_kid_5}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_5_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/5/payments)
    @url_pay_5  = "#{@oa.api_path}/students/5/payments"
    stub_request(:get, "#{@oa.api_url}#{@url_pay_5}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_5_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/6)
    @url_kid_6  = "#{@oa.api_path}/students/6"
    stub_request(:get, "#{@oa.api_url}#{@url_kid_6}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_6_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/6/payments)
    @url_pay_6  = "#{@oa.api_path}/students/6/payments"
    stub_request(:get, "#{@oa.api_url}#{@url_pay_6}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_6_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/7)
    @url_kid_7  = "#{@oa.api_path}/students/7"
    stub_request(:get, "#{@oa.api_url}#{@url_kid_7}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_7_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/7/payments)
    @url_pay_7  = "#{@oa.api_path}/students/7/payments"
    stub_request(:get, "#{@oa.api_url}#{@url_pay_7}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_7_PAYMENTS_HASH.to_json)

    # stub_request(:get, "http://demo.openapply.com/api/v3/students/95)
    @url_kid_95  = "#{@oa.api_path}/students/95"
    stub_request(:get, "#{@oa.api_url}#{@url_kid_95}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_95_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/95/payments)
    @url_pay_95  = "#{@oa.api_path}/students/95/payments"
    stub_request(:get, "#{@oa.api_url}#{@url_pay_95}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_95_PAYMENTS_HASH.to_json)
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
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/240)
    @url_kid_240  = "#{@oa.api_path}/students/240"
    stub_request(:get, "#{@oa.api_url}#{@url_kid_240}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_240_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/240/payments)
    @url_pay_240  = "#{@oa.api_path}/students/240/payments"
    stub_request(:get, "#{@oa.api_url}#{@url_pay_240}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_240_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/240)
    @url_kid_267  = "#{@oa.api_path}/students/267"
    stub_request(:get, "#{@oa.api_url}#{@url_kid_267}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_267_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/240/payments)
    @url_pay_267  = "#{@oa.api_path}/students/267/payments"
    stub_request(:get, "#{@oa.api_url}#{@url_pay_267}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_267_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/240)
    @url_kid_268  = "#{@oa.api_path}/students/268"
    stub_request(:get, "#{@oa.api_url}#{@url_kid_268}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_268_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/240/payments)
    @url_pay_268  = "#{@oa.api_path}/students/268/payments"
    stub_request(:get, "#{@oa.api_url}#{@url_pay_268}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_268_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/240)
    @url_kid_269  = "#{@oa.api_path}/students/269"
    stub_request(:get, "#{@oa.api_url}#{@url_kid_269}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_269_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/240/payments)
    @url_pay_269  = "#{@oa.api_path}/students/269/payments"
    stub_request(:get, "#{@oa.api_url}#{@url_pay_269}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_269_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/240)
    @url_kid_270  = "#{@oa.api_path}/students/270"
    stub_request(:get, "#{@oa.api_url}#{@url_kid_270}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_270_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/240/payments)
    @url_pay_270  = "#{@oa.api_path}/students/270/payments"
    stub_request(:get, "#{@oa.api_url}#{@url_pay_270}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_270_PAYMENTS_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/240)
    @url_kid_271  = "#{@oa.api_path}/students/271"
    stub_request(:get, "#{@oa.api_url}#{@url_kid_271}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_271_RECORD_HASH.to_json)
    # stub_request(:get, "http://demo.openapply.com/api/v3/students/240/payments)
    @url_pay_271  = "#{@oa.api_path}/students/271/payments"
    stub_request(:get, "#{@oa.api_url}#{@url_pay_271}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STUDENT_271_PAYMENTS_HASH.to_json)

    # https://demo.openapply.com/api/v3/students?status=applied&count=3
    @url_status_summary_p_1 = "#{@oa.api_path}/students/?status=applied&count=3"
    stub_request(:get, "#{@oa.api_url}#{@url_status_summary_p_1}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STATUS_APPLIED_PAGE_1_HASH.to_json)
    # https://demo.openapply.com/api/v3/students?status=applied&since_id=240&count=3
    @url_status_summary_p_2 = "#{@oa.api_path}/students/"
    stub_request(:get, "#{@oa.api_url}#{@url_status_summary_p_2}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STATUS_APPLIED_PAGE_2_HASH.to_json)
    # https://demo.openapply.com/api/v3/students?status=applied&since_id=269&count=3
    @url_status_summary_p_3 = "#{@oa.api_path}/students/?status=applied&since_id=269&count=3"
    stub_request(:get, "#{@oa.api_url}#{@url_status_summary_p_3}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STATUS_APPLIED_PAGE_3_HASH.to_json)

    # COUNT RETURN 5
    # https://demo.openapply.com/api/v3/students/?status=applied&count=5
    @url_status_applied_5 = "#{@oa.api_path}/students/?status=applied&count=5"
    stub_request(:get, "#{@oa.api_url}#{@url_status_applied_5}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STATUS_5_APPLIED_RECORDS_HASH.to_json)
    # https://demo.openapply.com/api/v3/students/?status=accepted&count=5
    @url_status_accepted_5 = "#{@oa.api_path}/students/?status=accepted&count=5"
    stub_request(:get, "#{@oa.api_url}#{@url_status_accepted_5}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STATUS_5_ACCEPTED_RECORDS_HASH.to_json)
    # https://demo.openapply.com/api/v3/students/?status=enrolled&count=5
    @url_status_enrolled_5 = "#{@oa.api_path}/students/?status=enrolled&count=5"
    stub_request(:get, "#{@oa.api_url}#{@url_status_enrolled_5}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STATUS_5_ENROLLED_RECORDS_HASH.to_json)
    # https://demo.openapply.com/api/v3/students/?status=bad&count=5
    @url_status_bad_5 = "#{@oa.api_path}/students/?status=bad&count=5"
    stub_request(:get, "#{@oa.api_url}#{@url_status_bad_5}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STATUS_5_BAD_RECORDS_HASH.to_json)
    #
    # COUNT RETURN 10
    # https://demo.openapply.com/api/v3/students/?status=applied&count=10
    @url_status_applied_10 = "#{@oa.api_path}/students/?status=applied&count=10"
    stub_request(:get, "#{@oa.api_url}#{@url_status_applied_10}")
          .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby', "Authorization" => "Bearer " + @oa.api_key})
          .to_return( status: 200, headers: {},
                      body: SpecData::STATUS_10_APPLIED_PAGES_ALL_HASH.to_json)
  end

  context "test the student summary api call" do
    before(:each) do
      allow(@oa).to receive(:api_records) { 3 }
    end
    # https://demo.openapply.com//api/v3/students?status=applied&count=3
    it "oa_api_call - get the first page students who are in applied" do
      test_answer = @oa.oa_api_call(@url_status_summary_p_1).response.body
      expect(test_answer).to eq SpecData::STATUS_APPLIED_PAGE_1_TEXT
    end
    # https://demo.openapply.com//api/v3/students?status=applied&since_id=240&count=3
    it "oa_api_call - get the second page students who are in applied" do
      test_answer = @oa.oa_api_call(@url_status_summary_p_2).response.body
      expect(test_answer).to eq SpecData::STATUS_APPLIED_PAGE_2_TEXT
    end
    # # https://demo.openapply.com//api/v3/students?status=applied&since_id=269&count=3
    it "oa_api_call - get the last page of students who are in applied" do
      test_answer = @oa.oa_api_call(@url_status_summary_p_3).response.body
      expect(test_answer).to eq SpecData::STATUS_APPLIED_PAGE_3_TEXT
    end
  end

  context "build correct urls for students summary queries" do
    let(:correct_answer) { "#{@oa.api_path}/students/?#{@placeholder}count=#{@oa.api_records}" }

    it "builds a correct url with NO parameters" do
      @placeholder = nil
      test_answer  = @oa.url_for_many_students_summaries()
      expect( test_answer ).to eq correct_answer
    end
    it "builds a correct url based on date" do
      # format: YYYY-MM-DD -- not yet 2013-09-25 02:10:39
      since_date   = Date.today - 2
      # since_date   = Time.zone.today - 2
      @placeholder = "since_date=#{since_date}&"
      test_answer  = @oa.url_for_many_students_summaries(nil,nil,since_date)
      expect( test_answer ).to eq correct_answer
    end
    it "builds a correct url based on status" do
      status       = 'applied'
      @placeholder = "status=#{status}&"
      test_answer  = @oa.url_for_many_students_summaries(status)
      expect( test_answer ).to eq correct_answer
    end
    it "builds a correct url based on status & since_id" do
      status       = 'applied'
      since_id     = '95'
      @placeholder = "status=#{status}&since_id=#{since_id}&"
      test_answer  = @oa.url_for_many_students_summaries(status,since_id)
      expect( test_answer ).to eq correct_answer
    end
    it "builds a correct url based on status & date" do
      status       = 'applied'
      since_date   = '2017-11-01'
      @placeholder = "status=#{status}&since_date=#{since_date}&"
      test_answer  = @oa.url_for_many_students_summaries(status,nil,since_date)
      expect( test_answer ).to eq correct_answer
    end
    it "builds a correct url based on status & date" do
      status       = 'applied'
      since_id     = '95'
      since_date   = '2017-11-01'
      @placeholder = "status=#{status}&since_id=#{since_id}&since_date=#{since_date}&"
      test_answer  = @oa.url_for_many_students_summaries(status,since_id,since_date)
      expect( test_answer ).to eq correct_answer
    end
  end

  context "many_students_details_by_ids " do
    before(:each) do
      @ids = [95, 106, 240, 267, 268, 269, 270, 271]
    end
    it "can query for a single page of student summaries" do
      # allow(@oa).to receive(:api_records) { 10 }
      test_answer = @oa.many_students_details_by_ids( @ids )
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_ALL_DETAILS_HASH
    end
    it "can query for a single page of student summaries w/o payments" do
      # allow(@oa).to receive(:api_records) { 10 }
      test_answer = @oa.many_students_details_by_ids( @ids, {get_payments: false} )
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_APPLIED_ALL_DETAILS_NO_PAYMENTS_HASH
    end
  end

  context "many_students_summaries - recursive" do
    it "gets all pages when of a given status" do
      allow(@oa).to receive(:api_records) { 5 }
      test_answer = @oa.many_students_summaries( {status: 'applied'} )
      # pp test_answer
      expect( test_answer ).to eq SpecData::STATUS_5_ALL_APPLIED_SUMMARIES_HASH
      # expect( test_answer ).to eq SpecData::STATUS_5_APPLIED_SUMMARY_HASH
    end
    it "gets all pages when of a bad status" do
      allow(@oa).to receive(:api_records) { 5 }
      test_answer = @oa.many_students_summaries( {status: 'bad'} )
      # pp test_answer
      expect( test_answer ).to eq( { students: [], guardians: [] } )
    end
  end

  context "many_students_ids" do
    it "gets all ids of a given status" do
      allow(@oa).to receive(:api_records) { 5 }
      correct_answer = {ids: [95, 106, 240, 267, 268]}
      test_answer = @oa.many_students_ids( {status: 'applied'} )
      # pp test_answer
      expect( test_answer ).to eq( correct_answer )
      # expect( test_answer ).to eq SpecData::STATUS_5_APPLIED_SUMMARY_HASH
    end
    it "ids_updated_at" do
      allow(@oa).to receive(:api_records) { 5 }
      correct_answer =  { :ids_updated_at=>
                          {
                            :students=> [
                              {95=>"2017-07-11T14:46:44.000+08:00"},
                              {106=>"2017-10-30T13:06:18.000+08:00"},
                              {240=>"2017-07-11T14:46:44.000+08:00"},
                              {267=>"2017-07-11T14:46:44.000+08:00"},
                              {268=>"2017-09-04T10:55:32.000+08:00"}
                            ],
                            :guardians=> [
                              {492=>"2017-07-11T14:46:48.000+08:00"},
                              {493=>"2017-07-11T14:46:48.000+08:00"},
                              {265=>"2017-09-04T16:30:18.000+08:00"},
                              {266=>"2017-09-01T12:04:26.000+08:00"},
                              {408=>"2017-07-11T14:46:48.000+08:00"},
                              {409=>"2017-07-11T14:46:48.000+08:00"},
                              {504=>"2017-07-11T14:46:48.000+08:00"},
                              {505=>"2017-07-11T14:46:48.000+08:00"},
                              {506=>"2017-07-11T14:46:48.000+08:00"}
                            ]
                          }
                        }
      test_answer = @oa.many_ids_updated_time( {status: 'applied'} )
      # pp test_answer
      expect( test_answer ).to eq( correct_answer )
    end
  end

  context "multiple status tests" do
    it "gets the right list of ids with two statuses" do
      allow(@oa).to receive(:api_records) { 5 }
      # test_answer = @oa.student_ids_by_status(['applied','enrolled'])
      test_answer = @oa.many_students_summaries({status:['applied','enrolled']})
      # pp test_answer
      # correct_ans = {student_ids: [95, 106, 240, 267, 268, 1, 4, 5, 6, 7]}
      correct_ans = SpecData::STATUS_5_APPLIED_ENROLLED_SUMMARY_HASH
      expect( test_answer ).to eq correct_ans
    end
    it "gets the right list of ids with three statuses (one bad status - accepted)" do
      allow(@oa).to receive(:api_records) { 5 }
      # test_answer = @oa.student_ids_by_status(['applied','enrolled'])
      test_answer = @oa.many_students_summaries({status:['applied','bad','enrolled']})
      # pp test_answer
      # correct_ans = {student_ids: [95, 106, 240, 267, 268, 1, 4, 5, 6, 7]}
      correct_ans = SpecData::STATUS_5_APPLIED_ENROLLED_SUMMARY_HASH
      expect( test_answer ).to eq correct_ans
    end
  end

  context "detailed lookup" do
    it "gets details by status" do
      allow(@oa).to receive(:api_records) { 10 }
      answer  = @oa.many_students_details( {status: 'applied'} )
      # pp answer
      correct = SpecData::STATUS_APPLIED_ALL_DETAILS_HASH
      expect( answer ).to eq correct
    end
    it "gets studentdetails - without payments" do
      allow(@oa).to receive(:api_records) { 10 }
      answer  = @oa.many_students_details( {status: 'applied'},
                                           {get_payments: false} )
      # pp answer
      correct = SpecData::STATUS_APPLIED_ALL_DETAILS_NO_PAYMENTS_HASH
      expect( answer ).to eq correct
    end
  end

end
