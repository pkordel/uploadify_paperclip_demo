class Photo < ActiveRecord::Base
  has_attached_file :photo, 
                    :path => "#{S3_CONFIG['key']}/:id/:basename.:extension",
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml", 
                    :s3_permissions => S3_CONFIG['acl'],
                    :bucket => S3_CONFIG['bucket_name']
end
