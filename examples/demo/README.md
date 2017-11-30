## Usage

In the terminal:

```bash
gem install openapply
# or better still
bundle install

irb
# or better still
pry
```
Once in the REPL - follow the below instructions

### Standard Usage - multiple classes accomodates multiple OpenApply Sites
```ruby

require 'pp'
require 'date'
require_relative './demo_site'

# use a class override in order to interact with multiple oa sites
# or extend functionality
@my  = MySite.new()


# get students with applied and enrolled status, flatten no fields,
# remove the parent_guardian (duplicate) info,
# move into the xlsx file the following data: studnet id and student name
# parent address (line 1) and country, and no payment info
@my.records_as_csv_to_file('applied', nil, [:parent_guardian],
                              [:id, :name],
                              {keys: [:address, :country]}, nil , "test-#{Date.today}.csv" )

@my.records_as_csv_to_server( 'applied', nil, [:parent_guardian],
                              [:id, :name],
                              {keys: [:address, :country]}, nil )

# DISABLED UNTIL AXLSX works with RubyZip 1.2.1
# # get students with applied and enrolled status, flatten the custom_fields,
# # remove the parent_guardian (duplicate) info,
# # move into the xlsx file the following data: studnet id and student name
# # parent address (line 1) and country, and the oldest three payment amounts & dates
# @my.records_as_xlsx_to_file(  ['applied','enrolled'], [:custom_fields],
#                               [:parent_guardian], [:id, :name],
#                               {count: 2, keys: [:address, :country]},
#                               {count: 3, order: :oldest, keys: [:amount, :date]}, "test-#{Date.today}.xlsx")
#
# @my.records_as_xlsx_to_server(['applied','enrolled'], [:custom_fields],
#                               [:parent_guardian], [:id, :name],
#                               {count: 2, keys: [:address, :country]},
#                               {count: 3, order: :newest, keys: [:amount, :date]})

# use cron or other similar tools to automate these processes
```


### Basic Usage using the gem directly - can only access one site
```ruby
require 'openapply'

# BASIC USAGE (see readme)
# use the .rbenv-vars for a simple setup
@oa    = Openapply::Client.new()

# see settings
@oa.api_url
@oa.api_key
@oa.base_path
@oa.api_timeout
@oa.api_reply_count


# student summarys with applied status
summaries   = @oa.students_by_status('applied')
student_ids = @oa.student_ids_by_status('applied')

ids         = student_ids[:student_ids]


# first student details - return data as is
details     = @oa.student_details_by_id(ids.first)

# last applied student details - custom fields -
# top level & duplicate :parent removed
flattened   = @oa.student_details_by_id(ids.last, [:custom_fields], [:parent_guardian])

# get first 5 records with status applied with student_ids greater than the last
# two records (which should return last six students) - but response is limited to 5
# updated after 5th of Nov 2016
custom      = @oa.students_query('applied', ids[-7] , '2016-11-05', 5)


# get students with applied and enrolled status, flatten no fields,
# remove the parent_guardian (duplicate) info,
# move into the xlsx file the following data: studnet id and student name
# parent address (line 1) and country, and no payment info
csv = @oa.students_as_csv_by_status( 'applied', nil, [:parent_guardian],
                              [:id, :name], {keys: [:address, :country]}, nil )
#
@oa.send_data_to_remote_server( csv, ENV['REMOTE_HOSTNAME'],
                                     ENV['REMOTE_USERNAME'], "#{ENV['REMOTE_PATH_FILE']}.csv", ENV['REMOTE_PERMISSIONS'])
# save csv string as a file locally
open('test_file.csv', 'w') { |f| f.puts csv }

# DISABLED UNTIL AXLSX works with RubyZip 1.2.1
#
# # get students with applied and enrolled status, flatten the custom_fields,
# # remove the parent_guardian (duplicate) info,
# # move into the xlsx file the following data: studnet id and student name
# # parent address (line 1) and country, and the oldest three payment amounts & dates
# xlsx = @oa.students_as_xlsx_by_status(['applied','accepted'], [:custom_fields],
#                                       [:parent_guardian], [:id, :name],
#                                       {count: 2, keys: [:address, :country]},
#                                       {count: , order: :oldest, keys: [:amount, :date]})
# #
# @oa.send_data_to_remote_server( xlsx, ENV['REMOTE_HOSTNAME'],    
#                                       ENV['REMOTE_USERNAME'], "#{ENV['REMOTE_PATH_FILE']}.xlsx", ENV['REMOTE_PERMISSIONS'])
# # save as a xlsx file locally
# xlsx.serialize('test_file.xlsx')

```
