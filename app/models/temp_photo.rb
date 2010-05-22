class TempPhoto < Photo
  has_attached_file :photo,
                    :styles => { :mini => '48x48#', :small => '178x92>', :product => '393x203>' }, 
                    :default_style => :product,
                    :path => ":rails_root/tmp/uploads/:id/:style/:basename.:extension" # Save it to a temporay location
                    
  # Save this as a regular upload on s3
  # this is run after the file is saved
  # and all post process stuff like
  # resizing is done
  after_save :queue_move_to_s3

  def queue_move_to_s3
    # Object method added by Delayed::Job
    # works like send()
    send_later(:move_to_s3)
  end

  def move_to_s3
    [:mini, :small, :product, :original].each do |style|
      temp_path = photo.path(style)
      temp_file = photo.to_file(style) # Paperclip's way of getting a File object for the attachment

      # Save it as a regular attachment
      # this will save to S3
      s3_upload = Photo.find(id) # Same db record but we need the S3 version
      s3_upload.photo = temp_file  # reset the file - it will assume its a new file
      s3_upload.save!             # Paperclip will upload the file on save

      # Delete the temporary file when we are done
      temp_file.close
      File.delete(temp_path)
    end
  end
end