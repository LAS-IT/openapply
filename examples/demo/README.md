## Usage
Start irb
```bash
bundle install

# irb
# or
pry
```

and run this code (or play )
```ruby
require 'pp'
require 'openapply'
require_relative './demo_site'


# BASIC USAGE (see readme)
# use the .rbenv-vars for a simple setup
@oa    = Openapply::Client.new()
@oa.one_student_record_by_id(95)

# see settings
@oa.api_url
@oa.api_key
@oa.base_path
@oa.api_timeout
@oa.api_reply_count
# replace record_count with reply count
# @oa.reply_count
```

* or More advanced - multiple OA sites
```ruby

require 'pp'
require 'openapply'
require_relative './demo_site'

# site - uses only code from gem
@oa = Openapply.new()

# student summarys with applied status
summaries  = @oa.students_by_status('applied')

# get first 5 records with status applied with student_ids greater than 150
# updated after 5th of Nov 2016
custom = @oa.custom_student_summaries('applied', '150', '2016-11-05', 5)

# complete student record
complete = @oa.student_details_by_id(95)

# get students with applied and enrolled status, flatten no fields,
# remove the parent_guardian (duplicate) info,
# move into the xlsx file the following data: studnet id and student name
# parent address (line 1) and country, and no payment info
csv = students_as_csv_by_status( 'applied', nil, :parent_guardian,
                            [:id, :name], {keys: [:address, :country]}, nil )
# save csv string as a file
open('test_file.csv', 'w') { |f| f.puts csv }

# get students with applied and enrolled status, flatten the custom_fields,
# remove the parent_guardian (duplicate) info,
# move into the xlsx file the following data: studnet id and student name
# parent address (line 1) and country, and the oldest three payment amounts & dates
xlsx = @oa.students_as_xlsx_by_status(['applied','enrolled'], [:custom_fields],
                                      [:parent_guardian], [:id, :name],
                                      {count: 2, keys: [:address, :country]},
                                      {count: 3, order: newest, keys: [:amount, :date]})
# save as a xlsx file
xlsx.serialize('test_file.xlsx')


# use a class override in order to interact with multiple oa sites
# or extend functionality
@mine  = MySite.new()


# get students with applied and enrolled status, flatten no fields,
# remove the parent_guardian (duplicate) info,
# move into the xlsx file the following data: studnet id and student name
# parent address (line 1) and country, and no payment info
@mine.records_as_csv_to_file(   'applied', nil, :parent_guardian, [:id, :name],
                                {keys: [:address, :country]}, nil , 'test.csv' )

@mine.records_as_csv_to_server( 'applied', nil, :parent_guardian, [:id, :name],
                                {keys: [:address, :country]}, nil )

# get students with applied and enrolled status, flatten the custom_fields,
# remove the parent_guardian (duplicate) info,
# move into the xlsx file the following data: studnet id and student name
# parent address (line 1) and country, and the oldest three payment amounts & dates
@mine.records_as_xlsx_to_file(  ['applied','enrolled'], [:custom_fields],
                                [:parent_guardian], [:id, :name],
                                {count: 2, keys: [:address, :country]},
                                {count: 3, order: newest, keys: [:amount, :date]}, 'test.xlsx')

@mine.records_as_xlsx_to_server(['applied','enrolled'], [:custom_fields],
                                [:parent_guardian], [:id, :name],
                                {count: 2, keys: [:address, :country]},
                                {count: 3, order: newest, keys: [:amount, :date]})

# use cron or other similar tools to automate these processes
```
