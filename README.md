[![Build Status](https://travis-ci.org/btihen/openapply.svg?branch=master)](https://travis-ci.org/btihen/openapply)  [![Dependency Status](https://beta.gemnasium.com/badges/github.com/btihen/openapply.svg)](https://beta.gemnasium.com/projects/github.com/btihen/openapply)  [![Known Vulnerabilities](https://snyk.io/test/github/btihen/openapply/badge.svg?targetFile=Gemfile.lock)](https://snyk.io/test/github/btihen/openapply?targetFile=Gemfile.lock)    [![Codacy Badge](https://api.codacy.com/project/badge/Grade/7b2062680fd14704bd321baef8dbddce)](https://www.codacy.com/app/btihen/openapply?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=btihen/openapply&amp;utm_campaign=Badge_Grade)  [![Codacy Badge](https://api.codacy.com/project/badge/Coverage/7b2062680fd14704bd321baef8dbddce)](https://www.codacy.com/app/btihen/openapply?utm_source=github.com&utm_medium=referral&utm_content=btihen/openapply&utm_campaign=Badge_Coverage)   [![Code Quality](https://bettercodehub.com/edge/badge/btihen/shop?branch=master)](https://bettercodehub.com/)  [![Coverage Status](https://coveralls.io/repos/github/btihen/openapply/badge.svg?branch=master)](https://coveralls.io/github/btihen/openapply?branch=master)




# Openapply

This gem allows ruby access to the OpenApply API v1 - and supports the GET features described at: https://dev.faria.co/oa


### Still TODO


### CHANGE LOG

* **v0.3.0** - NOT compatible with 0.2.x - 2018-01-??
  - refactor to use options - simplify and improve usage
  - refactor to be more modular (usage will change)

* **v0.2.10** - compatible with 0.2.x - 2018-01-04
  - updated rake and webmock gems in deve
  - removed roo - not needed

* **v0.2.9** - compatible with 0.2.x - 2017-12-13 *(https://github.com/straydogstudio/axlsx_rails/issues/77)*
    - separated convert (& its dependencies) into separate modules that can be loaded on need in the next version (0.3.x)
    - hash to array now handles both student_details and student_summaries (this also allows conversion then to csv)

* **v0.2.8** - compatible with 0.2.x - 2017-12-11 *(https://github.com/randym/axlsx/issues/234)*
  - axlsx - passes tests - but won't properly install inside another project (even using gem install ./openapply-0.2.7) - will look for a solution

* **v0.2.7** - compatible with 0.2.x - 2017-12-10
  - safely re-enabled axlsx by using the master branch and upgradeing rubyzip

* **v0.2.6** - compatible with 0.2.x - 2017-12-08
  - allow ssh/scp options to be passed

* **v0.2.5** - compatible with 0.2.x - 2017-11-30
  - removed a reference to AXLSX in scp transfers *(haven't figured out how to test that yet!)*

* **v0.2.4** - compatible with 0.2.x - 2017-11-30
  - rubyzip 1.1.7 - has a serious security flaw - Axlsx and Roo cannot use rubyzip 1.2.1 -- YET (which doesn't have the flaw) - so xlsx features are disabled until rubyzip 1.2.1 can be used by both roo and axlsx.  **CSV** conversions are still usable.  **BIG THANKS TO GitHub for the notification!**

* **v0.2.3** - compatible with 0.2.x - 2017-11-23
  - allow detailed queries *(_by_id & _by_status)* to skip payment information
  - allow array, csv & xlsx transformations to skip payment queries (when no payment_info requested)

* **v0.2.2** - compatible with 0.2.x - 2017-11-21
  - refactor and test url timeouts
  - refactor openapply client

* **v0.2.1** - compatible with 0.2.x - 2017-11-20
  - convert api data into an array, csv or xlsx
  - allow data flattening prep for post processing
  - allow queries to lookup students with multiple statuses
  - allow scp string object to file export (no automated tests)

* **v0.2.0** - first release -- **NOT** compatible with 0.1.0 -- 2017-11-07
  - get student details of a give status (and pure api calls)
  - recursive query until all receipt of all records received

* **v0.1.0** - test release -- 2017-11-01

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'openapply'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openapply


### Docs

* http://www.rubydoc.info/gems/openapply


#### Examples Code

see /examples in repo -- https://github.com/btihen/openapply/tree/master/examples/demo


### Configuration

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

### Instantiation
Associates the above settings with HTTParty
(so that you can access the OpenApply api)

```ruby
@oa = Openapply::Client.new
```

###  USAGE

#### USAGE SUMMARY

```ruby
# instantiate
@oa = OpenApply::Client.new

# see settings
@oa.api_url
@oa.api_key
@oa.base_path
@oa.api_timeout
@oa.api_records

# Individual student record
# (note: parent info is duplicated)
@oa.student_by_id( id )
@oa.payments_by_id( id )

# Query many students by params:
# params = {status: 'applied', since_id: 95, since_date: '2018-01-20', count: 50}
@oa.many_student_ids( params )
@oa.many_ids_updated_time( params )
@oa.many_students_details( params )
@oa.many_students_summaries( params )

# Student Details by IDs:
# id - student's record number
# options = {get_payments: false}
@oa.one_student_details_by_id( id, options={} )
# ids - in array format
@oa.many_student_details_by_ids( ids, options={} )

# directly call the OA API - with custom URL
@oa.oa_api_call('/api/v1/students/?status=accepted&count=5&auth_token=add_api_key')
```

#### OpenApply's allowed statuses

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


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/openapply. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Openapply project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/openapply/blob/master/CODE_OF_CONDUCT.md).
