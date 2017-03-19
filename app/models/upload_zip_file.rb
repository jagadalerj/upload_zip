class UploadZipFile < ActiveRecord::Base
  has_attached_file :zip_file
  validates_attachment_content_type :zip_file, content_type: ['application/zip']
end
