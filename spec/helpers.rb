require_relative "./data/hash/access_token"
module Helpers
  def method_name

  end

  def stub_auth(api_url)
    stub_request(:post, "#{api_url}/oauth/token").
          with(
            body: {"client_id"=>"xvz1evFS4wEEPTGEFPHBog", "client_secret"=>"L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg", "grant_type"=>"client_credentials"},
            headers: {
        	  'Accept'=>'*/*',
        	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        	  'Content-Type'=>'application/x-www-form-urlencoded',
        	  'User-Agent'=>'Faraday v1.0.1'
            }).
          to_return(status: 200, body: SpecData::ACCESS_TOKEN.to_json, headers: { 'Content-Type'=> 'application/json;charset=UTF-8'})
  end
end
