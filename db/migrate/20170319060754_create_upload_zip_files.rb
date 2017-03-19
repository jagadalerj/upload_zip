class CreateUploadZipFiles < ActiveRecord::Migration
  def change
    create_table :upload_zip_files do |t|
      t.attachment :zip_file	
      t.timestamps null: false
    end
  end
end
