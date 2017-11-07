# Openapply

This gem allows ruby access to the OpenApply API v1 - and supports the GET features described at: https://dev.faria.co/oa


### Still TODO

* test timeouts
* write PUTS methods
* **write method to flatten data structures**
* **write a recursive query to pull students with Multiple statuses**
* **write a to transform return hash of students to an array**
* **write a to transform return hash of students to a csv**
* write a recursive query to pull students by since date
* write a recursive query to pull students by since id
* **investigate slow response when returning large number of records**


### Installation

Add this line to your application's Gemfile:

```ruby
gem 'openapply'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openapply

## Usage

### Full Docs

* http://www.rubydoc.info/gems/openapply

### Configuration

* Setup / Config the following ENV-VARS (example code uses **.rbenv-vars**):

```bash
# timeout in seconds (before retry - 3 times)
OA_TIMEOUT=5

# 100 records is the advertised default record count, but in reality it is 10
OA_RELPY_RECORDS=100

# currently this is the only API path available
OA_API_PATH=/api/v1/students/

# point to your own site (this is the demo site)
OA_BASE_URI=demo.openapply.com

# this is the demo site key - you will need your own key for your own site
OA_AUTH_TOKEN=demo_site_api_key
```

### Instantiation
Associates the above settings with HTTParty
(so that you can access the OpenApply api)

```ruby
@oa = OpenApply::Client.new
```

#### Example Usage

```ruby
# instantiate
@oa = OpenApply::Client.new

# see settings
@oa.api_url
@oa.api_key
@oa.base_path
@oa.api_timeout
@oa.record_count
# replace record_count with reply count
# oa.reply_count
```

#### Method list

* individual student details

```ruby
# all student info & parents info
def student_by_id(student_id, options ={})
# all payments associated with a student
def payments_by_id(student_id, options={})
# this is all student details (combines studnet, parent and payments)
def student_details_by_id(id, flatten = false)
```

* group of students (summary data) -- **(recursive - collects all pages of records if return_count < total_records)**

```ruby
# summary info of students with a given status
def students_by_status(status)
# only student ids of students with a given status
def student_ids_by_status(status)
#
# returns all student details for all students of a given status **returned as a hash)**
def students_details_by_status(status)
#
# TODO: add in v0.2.1
# # returns all student details for all students of a given status **(returned as a csv string - only returns data matching the keys given)**
# def students_details_by_status_as_csv(status,keys)
# # returns all student details for all students of a given status **(returned as an array - only returns data matching the keys given)**
# def students_details_by_status_as_array(status,keys)
```

* custom grouping
```ruby
def custom_students_query(status=nil, since_id=nil, since_date=nil, count=api_records)
def custom_students_url(status=nil, since_id=nil, since_date=nil, count=api_records)
```

#### Get Individual student information

* Get a complete student record using student id -- includes: *(demographic, custom_fields, parent info & sibling ids)*

```ruby
# def one_student_record_by_id(student_id, options ={})

@oa = OpenApply::Client.new
@answer = @oa.student_by_id(95)

# answer formats include:
# { student:
#   { id: value1,
#     name: kid_name,
#     custom_fields: {
#       key3: value3,
#       key4: value4
#     }
#   },
#   linked: {
#     parents: [
#       id: value5,
#       name: parent_name,
#       custom_fields: {
#         key6: value6,
#         ...
#       }
#     ]
#   }
# }
```

* Get a student's payment records

```ruby
@oa = OpenApply::Client.new
@answer = @oa.payments_by_id(95)

# answer format is:
# {
#    payments: [
#       {key1: value1, key2: value2},
#       {key1: value3, key2: value3}
#    ],
# }
```

* Get all student data about one individual - includes: *(demographic, gardians, sibling ids, & payment records)*

```ruby
@oa = OpenApply::Client.new
@answer = @oa.student_details_by_id(95)

# answer format is:
# { student:
#   {
#     id: id,
#     record:
#       { id: id,
#         name: kid_name,
#         ... ,
#         custom_fields: {
#           key2: value2,
#           ...
#         }
#       },
#     payments: [
#       {payment1},
#       {payment2}
#     ],
#     guardians: [
#       { id: id,
#         name: guardian1,
#         ... ,
#         custom_fields: {
#           key2: value2,
#           ...
#         }
#       },
#       { id: id,
#         name: guardian2,
#         ... ,
#         custom_fields: {
#           key2: value2,
#           ...
#         }
#       }
#     ]
#   }
# }
```

#### Group queries (by status)

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


* Get student summary info of all students of a given status **(all pages - uses recursion)**

```ruby
# def all_student_summaries_by_status(status)

@oa = OpenApply::Client.new
@answer = @oa.students_by_status('applied')

# answer format is:
# { students: [
#      { id: id1,
#        name: kid1,
#        ...,
#      { id: id2,
#        name: kid_name_2,
#        ...,
#      }
#   ],
#   linked: {
#     parents: [
#       id: value5,
#       name: parent_name,
#       custom_fields: {
#         key6: value6,
#         ...
#       }
#     ]
#   }
# }
```

* Get a list of student ids of all students of a given status **(all pages - uses recursion)**

```ruby
# def all_student_ids_by_status(status)

@oa = OpenApply::Client.new
@answer = @oa.student_ids_by_status('applied')

# answer format is:
# { student_ids: [95, 160, 240] }
```

* Get all student data of all students of a given status **(all pages - uses recursion)**

```ruby
# def all_students_all_data_by_status(status)

@oa = OpenApply::Client.new
@answer = @oa.students_details_by_status('enrolled')

# TODO: add correct info
# answer formats include:
# { students:
#   [
#     { id: value1,
#       key2: value2,
#       custom_fields: {
#         key3: value3,
#         key4: value4
#       }
#     },
#     { id: valueX,
#       key2: valueY,
#       custom_fields: {
#         key3: valueZ,
#         key4: valueA
#       }
#     }
#   ],
#   guardians: [
#     {
#       id: value5,
#       custom_fields: {
#         key6: value6,
#         ...
#      },
#     {
#       id: value6,
#       custom_fields: {
#         key6: value7,
#         ...
#      },
#   ]
# }
```


* Get all student data of all students of a given status **(all pages - uses recursion)**

```ruby
# FLATTEN RECORDS
# def all_students_all_data_by_status(status,true)

@oa = OpenApply::Client.new
@answer = @oa.students_details_by_status('enrolled',true)

# answer formats include:
# { students:
#   [
#     { id: value1,
#       name: kid_1,
#       key3: value3,
#       key4: value4
#     },
#     { id: valueX,
#       name: kid_2,
#       key3: valueZ,
#       key4: valueA
#     }
#   ],
#   guardians: [
#     { id: value5,
#       name: guardian_1
#       key6: value6,
#       ...
#     },
#     { id: value6,
#       name: guardian_2
#       key6: value7,
#       ...
#     },
#   ]
# }
```

#### Custom URL (GET) API calls

* Get student summary info of students with a custom query - supporting the description here: https://dev.faria.co/oa/#responses **(one page - no recursion)**

```ruby
# def custom_student_summaries(status=nil, since_id=nil, since_date=nil, count=self.record_count)

@oa = OpenApply::Client.new
# status -- return records matching this status
# since_id -- return records with ids after this id
# since_date (format: 'YYYY-MM-DD') -- return records updated after this date
# count (>= 1) -- is the number of records to return
@answer = @oa.students_custom('applied',240,nil,3)
@answer = @oa.students_custom('applied',nil,'2015-09-12',3)

# answer formats include:
# { students:
#   [
#     { id: value1,
#       name: kid_1,
#       ...,
#       custom_fields: {
#         key3: value3,
#         key4: value4
#       }
#     },
#     { id: valueX,
#       name: kid_2,
#       ...,
#       custom_fields: {
#         key3: valueZ,
#         key4: valueA
#       }
#     }
#   ],
#   linked: {}
#     parents: [
#       {
#         id: value5,
#         name: parent_1,
#         ...,
#         custom_fields: {
#           key6: value6,
#           ...
#       },
#       {
#         id: value6,
#         name: parent_2,
#         ...,
#         custom_fields: {
#           key6: value7,
#           ...
#       },
#     ]
#   }
#   meta: {
#     page: 3,
#     per_page": "2"
#   }
# }
```

* Get a response to a custom url query - this is the lowest level access

```ruby
# def oa_answer( url, options={} )

url = "api/v1/students?since_id=269&auth_token=demo_site_api_key"

@oa = OpenApply::Client.new
@oa_answer = @oa.oa_answer( url )

# answer format like:
#<HTTParty::Response:0x7f851fa20408 parsed_response="{\"payments\":[]}", @response=#<Net::HTTPOK 200  readbody=true>, @headers={}>
#
# access data using something like:
return { error: "no answer" } unless @oa_answer.responds_to? 'response'
return { error: "no answer" } unless (@oa_answer.response).responds_to? 'body'
return JSON.parse( @api_answer.response.body, symbolize_names: true )

# answer formats include:
# { student:
#   { id: value1,
#     key2: value2,
#     custom_fields: {
#       key3: value3,
#       key4: value4
#     }
#   },
#   linked: {
#     parents: [
#       id: value5,
#       custom_fields: {
#         key6: value6,
#         ...
#       }
#     ]
#   }
# }
#   or
# {
#    payments: [
#       {key1: value1, key2: value2},
#       {key1: value3, key2: value3}
#    ],
# }
#   or
# {
#   students: [
#     {id: value1, key2: value2, custom_fields: {key3: value3, key4: value4} },
#     {id: value3, key2: value3, custom_fields: {key3: value3, key5: value5} }
#   ],
#   linked: {
#     parents: [
#       id: value5,
#       custom_fields: {
#         key6: value6,
#         ...
#       }
#     ]
#   }
#   meta: {
#     page: 3,
#     per_page": "10"
#   }
# }
```

#### Group queries with recursion (by since_date)
not done (just code stubs)- not yet needed

#### Group queries with recursion (by since_id)
not done (just code stubs)- not yet needed

#### See Examples Folder

for an actual complete code examples

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/openapply. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Openapply project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/openapply/blob/master/CODE_OF_CONDUCT.md).
