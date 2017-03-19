class UplaodZipFilesController < ApplicationController
 before_action :uploaded_file, only: [:edit, :update, :show, :destroy, :parse_file] 
 include UplaodZipFilesHelper

  def index
     @uploaded_zip_files = UploadZipFile.all
  end

  def new
    @upload_zip_file = UploadZipFile.new
    @url = uplaod_zip_files_path
  end

  def create
  	@upload_zip_file = UploadZipFile.new(upload_zip_file_params)
    if @upload_zip_file.save
      flash[:success] = "Upload Zip File Successfully!"
      redirect_to root_path 
    else
      flash[:error] = @upload_zip_file.errors.full_messages[0]
      redirect_to :back
    end
  end
  
  def edit
    @url = uplaod_zip_file_path(@upload_zip_file)
  end

  def update
    if @upload_zip_file.update(upload_zip_file_params)
      flash[:success] = "Update Zip File Successfully!"	
      redirect_to root_path
    else
      flash[:error] = @upload_zip_file.errors.full_messages[0]
      redirect_to :back	
    end
  end

  def show
    read_file(@upload_zip_file, nil)
  end
  
  def parse_file
    unless params[:xml_file_name].blank? || params[:id].blank?
      read_file(@upload_zip_file, params[:xml_file_name])        
    else
      flash[:error] = "Something Went Wrong..!"
    end
  end

  def destroy
  	@upload_zip_file.destroy
  	flash[:success] = "Destroy Zip File Successfully!"
  	redirect_to root_path
  end

  private
   
   def uploaded_file
     @upload_zip_file = UploadZipFile.find(params[:id])
   end

   def upload_zip_file_params
     params.require(:upload_zip_file).permit(:zip_file)
   end
end
