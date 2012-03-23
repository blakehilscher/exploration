class Admin::SlidePhotosController < AdminController
  
  before_filter :load_dependencies
  
  def load_dependencies
    @slideshow = Slideshow.find params[:slideshow_id]
    @slide = @slideshow.slides.find params[:slide_id]
  end
  
  def index
    respond_with @photos = @slide.photos
  end

  def show
    respond_with @photo = @slide.photos.find(params[:id])
  end

  def new
    respond_with @photo = @slide.photos.new
  end

  def edit
    @photo = @slide.photos.find(params[:id])
  end

  def create
    @photo = @slide.photos.new(params[:slide_photo])
    if @photo.save
      flash[:notice] = "Photo Added!"
      redirect_to edit_admin_slideshow_url(@slideshow)
    else
      flash[:error] = "Error!"
      respond_with @photo
    end
  end

  def update
    @photo = @slide.photos.find(params[:id])
    @photo.update_attributes(params[:slide_photo])
    respond_with @photo, :location => edit_admin_slideshow_url(@slideshow)
  end

  def destroy
    @photo = @slide.photos.find(params[:id])
    @photo.destroy
    respond_with @photo, :location => edit_admin_slideshow_url(@slideshow)
  end

  def sortable
    @photos = @slide.photos
    @photos.each do |slide_photo|
      slide_photo.position = params['slide_photo'].index(slide_photo.id.to_s) + 1
      slide_photo.save
    end
    render :nothing => true
  end
end
