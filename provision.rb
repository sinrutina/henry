require 'dotenv'
require 'aws-sdk'

Dotenv.load

s3 = Aws::S3::Client.new
resp = s3.list_buckets
puts resp.buckets.map(&:name)


