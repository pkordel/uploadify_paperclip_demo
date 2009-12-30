Paperclip.interpolates(:s3_authenticated_url) do |attachment, style| 
  AWS::S3::S3Object.url_for(attachment.path(style), attachment.bucket_name, :use_ssl=>true, :expires_in=>3.minutes) 
end 
