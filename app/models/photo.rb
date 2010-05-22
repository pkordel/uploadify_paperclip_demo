class Photo < ActiveRecord::Base
  has_attached_file :photo, 
                    :styles => { :mini => '48x48#', :small => '178x92>', :product => '393x203>' }, 
                    :default_style => :product,
                    :path => "#{S3_CONFIG['key']}/:id/:style/:basename.:extension",
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml", 
                    :s3_permissions=>'private', :url=>':s3_authenticated_url'
end
