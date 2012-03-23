class Admin::SlidesController < AdminController
  
  before_filter :load_dependencies
  
  def load_dependencies
    @slideshow = Slideshow.find params[:slideshow_id]
  end
  
  def index
    respond_with @slides = @slideshow.slides
  end

  def show
    @slide = @slideshow.slides.find(params[:id])
    @photo = @slide.photos.new
    respond_with @slide, @photo
  end

  def new
    @slide = @slideshow.slides.create!
    redirect_to new_admin_slideshow_slide_slide_photo_url(@slideshow, @slide)
    #@slide = @slideshow.slides.new
    #respond_with @slide, @photo
    
  end

  def edit
    @slide = @slideshow.slides.find(params[:id])
    @photo = @slide.photos.new
  end

  def create
    @slide = @slideshow.slides.new(params[:slide])
    if @slide.save
      flash[:notice] = "Slide Created!"
      redirect_to edit_admin_slideshow_url(@slideshow)
    else
      respond_with @slide
    end
  end

  def update
    @slide = @slideshow.slides.find(params[:id])
    @slide.update_attributes(params[:slide])
    respond_with @slide, :location => edit_admin_slideshow_url(@slideshow)
  end

  def destroy
    @slide = @slideshow.slides.find(params[:id])
    @slide.destroy
    respond_with @slide, :location => edit_admin_slideshow_url(@slideshow)
  end

  def sortable
    @slides = @slideshow.slides
    @slides.each do |slide|
      slide.position = params['slide'].index(slide.id.to_s) + 1
      slide.save
    end
    render :nothing => true
  end
end
