#!/usr/bin/env ruby

require 'csv'
require 'net/scp'
require 'stringio'
require 'httparty'

class DemoSite < Openapply::Client
  include HTTParty

  # these next two are needed in a subclass to interact with multiple OA sites
  localized_url = ENV['OA_BASE_URI']
  base_uri localized_url

  def api_key
    ENV['OA_AUTH_TOKEN']
  end

  # Business logic: create a csv file of a given status & transfer it

  def student_ids_names_by_status_to_csv(status)
    # best is to check if status is in the list of valid statuses
    return { error: "no status"}  if status.to_s.eql? ""

    # # this next step is slow (for 100 kids) - investigate
    # student_hash  = all_students_all_data_by_status(status)
    student_hash  = students_by_status(status)


    student_array = students_hash_to_students_array(student_hash)
    student_csv   = students_array_into_csv_string(student_array)
  end

  def students_hash_to_students_array(hash)
    array   = []
    csv_keys = [:id, :first_name, :last_name]

    headers  = csv_keys.map{|k| k.to_s}
    # headers  = ['id','first_name','last_name']
    puts headers

    array  << headers

    # don't loop if hash is empty
    return headers      if hash.empty?

    hash[:students].each do |record|
      row = []
      # skip record if empty
      # puts "#{record[:record]}\n"
      next              if record.nil?
      next              if record.nil?
      next              if record.empty?

      # find the desired fields and add them to the csv
      csv_keys.each{ |key| row << record[key] }

      # add row to the master arrary
      array << row
    end
    return array
  end

  def students_array_into_csv_string(array)
    return ""              if array.nil?
    return ""              if array.empty?
    # https://stackoverflow.com/questions/4822422/output-array-to-csv-in-ruby
    csv_string = CSV.generate do |csv|
      array.each do |row|
        csv << row
      end
    end
    return csv_string
  end

end
