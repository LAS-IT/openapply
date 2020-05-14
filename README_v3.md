# Openapply v3

This gem allows ruby access to the OpenApply API v3 - and supports the GET features described at: https://(your openapply domain)/help/api_v3

## TODO
- [x] implement OAuth 2.0
- [x] update students GET wrapper
- [x] update students payement info GET wrapper
- [] implement students advanced search
- [] implement parents GET wrapper
- [] implement parents advanced search
- [] implement students and parent PUT wrapper

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openapply', "~> 1.0"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openapply -v "~> 1.0"

## Docs

* http://www.rubydoc.info/gems/openapply


## Configuration

Note: (these are example value uses your own **.rbenv-vars**):

* Setup / Config the following ENV-VARS

```bash
# Please set this before instantiation
# timeout in seconds (before retry - 3 times)
OA_TIMEOUT=5
```

* Setup your defaults

```bash
# 100 records is the advertised default
OA_RELPY_RECORDS=100

# point to your own site (this is the demo site)
OA_BASE_URI=demo.openapply.com

# this is the demo site key - you will need your own key for your own site
# from https://demo.openapply.com/admin/dashboard (it will reset every two hours)
# navigate to Settings > Integrations, and enable the API, and generate a client id and client secret
OA_CLIENT_ID=demo_site_client_id
OA_CLIENT_SECRET=demo_site_client_secret
```

## Instantiation
You can also associate your own configuration value on the fly using instantiation arguments, if an arguments is missing it will fallback to ENV variables for this specific arguments.

```ruby
@oa = Openapply::Client.new(url: "", client_id: "", client_secret: "", token: "")
```

## USAGE

### Authentication
If `:token` is not present, a new token will be generated, tokens are valid for ~30 days. For performance optimization we encourage you to cache your token, and regenerate one when it expires. You can find a rails example on the wiki.  

### USAGE SUMMARY

```ruby
require 'openapply'
# instantiate
@oa = Openapply::Client.new

# see settings
@oa.api_url
@oa.api_key
# => auth_token
@oa.api_path
@oa.api_timeout
@oa.api_records
@oa.api_client_id
@oa.api_client_secret

# get auth token
@oa.authentificate
# => OAuth2::AccessToken

# Individual student record
# (note: parent info is duplicated)
@oa.student_by_id( id )
@oa.payments_by_id( id )

# Student Details by IDs:
# id - student's record number
# options = {get_payments: false}
@oa.one_student_details_by_id( id, options={} )
# ids - in array format
@oa.many_students_details_by_ids( ids, options={} )

# Query many students by params:
# params = {status: 'applied', since_id: 95, since_date: '2018-01-20', count: 50}
@oa.many_students_ids( params )
@oa.many_ids_updated_time( params )
@oa.many_students_summaries( params )
@oa.many_students_details( params, options )

# directly call the OA API - with custom URL
@oa.oa_api_call('/api/v1/students/?status=accepted&count=5&auth_token=add_api_key')
```

### OpenApply's allowed statuses

* **valid status includes:**
  - Status
  - Pending
  - Applied
  - Admitted
  - Wait-listed
  - Declined
  - Enrolled
  - Graduated
  - Withdrawn
