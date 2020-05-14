# Openapply v1

This gem allows ruby access to the OpenApply API v1 - and supports the GET features described at: https://(your openapply domain)/help/api_v1


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openapply', "~> 0.4"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openapply  -v "~> 0.4"

## Docs

* http://www.rubydoc.info/gems/openapply


## Configuration

* Setup / Config the following ENV-VARS (example code uses **.rbenv-vars**):

```bash
# timeout in seconds (before retry - 3 times)
OA_TIMEOUT=5

# 100 records is the advertised default record count, but in reality it is 10
# this gem uses 50 as the default
OA_RELPY_RECORDS=50

# currently this is the only API path available
OA_API_PATH=/api/v1/students/

# point to your own site (this is the demo site)
OA_BASE_URI=demo.openapply.com

# this is the demo site key - you will need your own key for your own site
# from https://demo.openapply.com/admin/dashboard (it will reset every hour)
# navigate to Settings > Integrations, and enable the API, and generate a token
OA_AUTH_TOKEN=demo_site_api_key
```

## Instantiation
Associates the above settings with HTTParty
(so that you can access the OpenApply api)

```ruby
@oa = Openapply::Client.new
```

##  USAGE

### USAGE SUMMARY

```ruby
require 'openapply'
# instantiate
@oa = Openapply::Client.new

# see settings
@oa.api_url
@oa.api_key
@oa.api_path
@oa.api_timeout
@oa.api_records

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
