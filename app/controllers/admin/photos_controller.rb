class Admin::PhotosController < AdminController
  
  def index
    respond_with @photos = Photo.all
  end

  def show
    respond_with @photo = Photo.find(params[:id])
  end
  
  def new
    respond_with @photo = Photo.new
  end
  
  def edit
    @photo = Photo.find(params[:id])
  end
  
  def create
    @photo = Photo.new(params[:photo])
    if @photo.save
      flash[:notice] = "Photo #{@photo.image.to_s.split('/').last} Successfully Created! <a href='#{admin_photos_url}'>View All Photos</a>"
      redirect_to new_admin_photo_url
    else
      respond_with @photo
    end
  end
  
  def update
    @photo = Photo.find(params[:id])
    @photo.update_attributes(params[:photo])
    respond_with @photo, :location => admin_photos_url
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    respond_with @photo, :location => admin_photos_url
  end
  
  def sortable
    @photos = Photo.all
    @photos.each do |photo|
      photo.position = params['photo'].index(photo.id.to_s) + 1
      photo.save
    end
    render :nothing => true
  end
  
end
