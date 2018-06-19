require 'openapply'

# SET ENV VARIABLES - NEEDED VARIABLES:
# OA_TIMEOUT=5
# OA_RECORD_COUNT=50
# OA_API_PATH=/api/v1/students/
# OA_BASE_URI=demo.openapply.com
# OA_AUTH_TOKEN=(this only works for an hour after setup)

# instantiate openapply connection
@oa = Openapply::Client.new

# see settings
@oa.api_url
@oa.api_key
@oa.api_path
@oa.api_timeout
@oa.api_records

# get summary info of applied kids
params = {status: 'applied'}
summaries = @oa.many_students_summaries( params )

# get information details on one student
oa_id = 123456
one_details = @oa.one_student_details_by_id(oa_id)

# get details of of many kids - after kid 95 (only get 50 records at a time)
params = {since_id: 95, count: 50}
kid_ids   = @oa.many_students_ids( params )
details   = @oa.many_students_details_by_ids( kid_ids )

# get all student records that have been updated in the last week
params = {since_date: "#{Date.today-7}"}
updates   = @oa.many_ids_updated_time( params )

# Update Student ID
update_id = @oa.update_student_id(533497, 533497)
