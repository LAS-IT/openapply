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

# use a class override in order to interact with multiple oa sites
@demo  = DemoSite.new()

# get 5 summary records
hash  = @demo.custom_student_summaries('applied', nil, nil, 5)

# get all students
hash  = students_by_status('applied')
array = @demo.students_hash_to_students_array(hash)
csv_1 = @demo.students_array_into_csv_string(array)
# @demo.send_csv_to_server(csv_1, 'host.example.io', 'user', '/home/user/file1.csv')

# SLOW takes minutes
csv_2 = @demo.student_ids_names_by_status_to_csv('applied')
# @demo.send_csv_to_server(csv_2, 'host.example.io', 'user', '/home/user/file2.csv')

```
