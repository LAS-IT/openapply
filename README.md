# Openapply

This gem allows ruby access to the OpenApply API v1 - and supports the GET features described at: https://dev.faria.co/oa


### Still TODO

* allow flattening to work with arrays?
* allow flattening and reject to work at 2 levels of depth?
* make tests for scp / ssh (at least data type conversions)?
* write PUTS methods - *currently api only allows status update*
* write a recursive custom query - when results are more than one page
* allow flattening and reject to work at any depth (with recursion)?
* speed up response when returning large number of records? - **looks like API**


### CHANGE LOG

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
@oa = OpenApply::Client.new
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
#
# directly call against the OA API
@oa.oa_api_call('/api/v1/students/?status=accepted&count=5&auth_token=add_api_key')
#

# Individual students records (separated)
@oa.student_by_id(95)
@oa.payments_by_id(95)
#
# individual student records combined & possible pre-processing
# ATTRIBUTES: id, [:keys_to_un-nest], [:keys_to_exclude]
@oa.student_details_by_id(95)
@oa.student_details_by_id(95, [:custom_fields], [:parent_guardian])
# skip payment info -- (payments: [])
@oa.student_details_by_id(95, [], [], false)
@oa.student_details_by_id(95, [:custom_fields], [:parent_guardian], false)
#
# student summaries of a given status (recursively if more than on page)
@oa.students_by_status('applied')
#
# student details of a given status (recursively if more than on page)
@oa.students_details_by_status('applied')
@oa.students_details_by_status('applied', [:custom_fields])
@oa.students_details_by_status('applied', [], [:parent_guardian])
@oa.students_details_by_status('applied', [:custom_fields], [:parent_guardian])
# skip payment info (payments: [])
@oa.students_details_by_status('applied', [], [], false)
@oa.students_details_by_status('applied', [:custom_fields], [:parent_guardian], false)
#
# student details with multiple status (recursively if more than on page)
@oa.students_details_by_statuses(['applied','enrolled'], [:custom_fields])
@oa.students_details_by_statuses(['applied','enrolled'], nil, [:parent_guardian])
@oa.students_details_by_statuses(['applied','enrolled'], [:custom_fields], [:parent_guardian])
# speed up and skip payment info - returns [] in payment area
@oa.students_details_by_statuses(['applied','enrolled'], [], [], false)
# speed up and skip payment info - returns [] in payment area
@oa.students_details_by_statuses(['applied','enrolled'], [:custom_fields], [:parent_guardian], false)
#
# create an array
@oa.students_as_array_by_status('applied', [:custom_fields], [:parent_guardian], [:id, :name], {count: 1, keys: [:id, :name, :address]}, {count: 2, order: :newest, keys: [:date, :amount]} )
# multiple statuses into an array
@oa.students_as_array_by_statuses(['applied','enrolled'], [:custom_fields], [:parent_guardian], [:id, :name], {count: 1, keys: [:id, :name, :address]}, {count: 2, order: :newest, keys: [:date, :amount]} )
#
# Create a csv string
@oa.students_as_csv_by_status('applied',[:custom_fields], [:parent_guardian], [:id, :name], {type: :guardians, count: 1, keys: [:id, :name, :address]}, {type: :payments, count: 2, order: :newest, keys: [:date, :amount]} )
# multiple status into
csv_string=@oa.students_as_csv_by_statuses(['applied','enrolled'],[:custom_fields], [:parent_guardian], [:id, :name], {type: :guardians, count: 1, keys: [:id, :name, :address]}, {type: :payments, count: 2, order: :newest, keys: [:date, :amount]} )
#
# send CSV to a remote server as a file - using ssh-keys
@oa.send_data_to_remote_server(csv_string, 'hostname.domain.name', 'myusername', '/home/myusername/xfer/myexport.csv', '0750')
#
# send CSV to a remote server as a file - using ssh-keys - don't check host_key of remote server
@oa.send_data_to_remote_server( csv_string, 'hostname.domain.name', 'myusername', '/home/myusername/xfer/myexport.csv', '0750', {verify_host_key: false} )

# Create XLSX file
# @oa.students_as_xlsx_by_status('applied',[:custom_fields], [:parent_guardian], [:id, :name], {type: :guardians, count: 1, keys: [:id, :name, :address]}, {type: :payments, count: 2, order: :newest, keys: [:date, :amount]} )
# # # multiple status into
# xlsx_obj=@oa.students_as_xlsx_by_statuses(['applied','enrolled'],[:custom_fields], [:parent_guardian], [:id, :name], {type: :guardians, count: 1, keys: [:id, :name, :address]}, {type: :payments, count: 2, order: :newest, keys: [:date, :amount]} )
# #
# # send XLSX to a remote server as a file - using ssh-keys
# @oa.send_data_to_remote_server(xlsx_obj, 'hostname.domain.name', 'myusername', '/home/myusername/xfer/myexport.xlsx', '0750')
```

#### INDIVIDUAL STUDENT QUERIES

```ruby
# all student info & parents info -- returns the data straight from OpenApply
student_record = @oa.student_by_id(95)

# all payments associated with a student -- returns the data straight from OpenApply
student_payments = @oa.payments_by_id(95)

# Returns all student details (combines studnet, parent and payments)
# **flatten_keys** - brings these keys to the top level - prepending the group name to the key name -- we usually use:
#  flatten_keys = [:custom_fields]
# **reject keys** -- removes the data matching these keys -- we usually use:
#  reject_keys = [:parent_guardian] (since this is duplicated)
# returns the data structured as:
#   { student: {
#       id: xxx,
#       record: {xxx}      # complete student record
#       guardians: [ {} ]  # all guardian information
#       payments: [ {} ]   # all payments made via openapply
#     }
#   }
@oa.student_details_by_id(95)
# or
@oa.student_details_by_id(95, [:custom_fields], [:parent_guardian])
```

#### DATA OF GROUPS OF STUDENTS

searched recursively - collects all pages of records

```ruby
# SUMMARY INFO of students with a given status - ONLY ONE STATUS string!
@oa.students_by_status('applied')

# STUDENT IDs of students with a given status or array of statuses
ids = @oa.student_ids_by_status('applied')
ids = @oa.student_ids_by_statuses(['applied','enrolled'])
# [1, 2, 60]
#
# FULL STUDENT DETAILS for all students of a given status or statuses
# **returned as a hash)** -- attributes are (status, flatten_keys, reject_keys)
# example usage:
@oa.students_details_by_status('applied')
@oa.students_details_by_status('applied',[:custom_fields])
@oa.students_details_by_status('applied', [:custom_fields], [:parent_guardian])
@oa.students_details_by_status(['applied','enrolled'])
@oa.students_details_by_status(['applied','enrolled'], nil, [:parent_guardian])
```


#### STUDENT DATA TRANFORMATIONS

```ruby
# student details - in an array format (instead of hash)
# ATTRIBUTES - status, flatten_keys, reject_keys, student_keys(into array), guardian_info(into array), payment_info(into array)
# guardian and payment info options:
# count - how many records to return
# keys - which keys to return to array/csv
# order: :newest/:oldest (for payments) - return newest or oldest payments first
@oa.students_as_array_by_status('applied', nil, nil, [:id, :name], nil, {count: 2, order: :newest, keys: [:date, :amount]} )
# all options
@oa.students_as_array_by_status('applied',[:custom_fields], [:parent_guardian], [:id, :name], {count: 1, keys: [:id, :name, :address]}, {count: 2, order: :newest, keys: [:date, :amount]} )
#
# Create a csv string
@oa.students_as_csv_by_status('applied', nil, nil, [:id, :name], nil, {count: 2, order: :newest, keys: [:date, :amount]} )
# all options
csv=@oa.students_as_csv_by_status('applied',[:custom_fields], [:parent_guardian], [:id, :name], {count: 1, keys: [:id, :name, :address]}, {count: 2, order: :newest, keys: [:date, :amount]} )
#
# send CSV to a remote server as a file - using ssh-keys
# attributes: csv_string, srv_hostname, srv_username, srv_path_file, file_permissions(0750 - default if not specified)
@oa.send_data_to_remote_server(csv, 'hostname.domain.name', 'myusername', '/home/myusername/xfer/myexport.csv', '0750')
#
# # Create a XLSX package
@oa.students_as_xlsx_by_status('applied', nil, nil, [:id, :name], nil, {count: 2, order: :newest, keys: [:date, :amount]} )
# # all options
xlsx_obj=@oa.students_as_xlsx_by_status('applied',[:custom_fields], [:parent_guardian], [:id, :name], {count: 1, keys: [:id, :name, :address]}, {count: 2, order: :newest, keys: [:date, :amount]} )
# #
# # send CSV to a remote server as a file - using ssh-keys
# # attributes: csv_string, srv_hostname, srv_username, srv_path_file, file_permissions(0750 - default if not specified)
@oa.send_data_to_remote_server(xlsx_obj, 'hostname.domain.name', 'myusername', '/home/myusername/xfer/myexport.csv', '0750')
```

#### CUSTOM GROUP QUERIES - summary data

```ruby
# status = 'applied'        # all records matching a valid openapply status
# since_id = 95             # all records with ids after 95
# since_date = '2017-11-12' # all records modified after 2017-11-12 (& time)
# count = 20                # records per page

# build a custom url query to send to OA api
# returns a url that can be passed to api
@oa.students_query_url('applied', 106, '2017-11-12', 25)

# executes a custom query and returns a group of student summaries matching criteria
@oa.students_query('applied', 106, '2017-11-12', 25)
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
