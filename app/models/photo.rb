class Photo < ActiveRecord::Base
  has_attached_file :photo, 
                    :styles => { :thumb => "100x100>" },
                    :path => "images/products/:id/:style/:basename.:extension",
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
                    :bucket => "YOUR_BUCKET"
end
