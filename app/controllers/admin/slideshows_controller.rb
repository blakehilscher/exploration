class Admin::SlideshowsController < AdminController
  
  def index
    respond_with @slideshows = Slideshow.all
  end

  def show
    respond_with @slideshow = Slideshow.find(params[:id])
  end

  def new
    respond_with @slideshow = Slideshow.new
  end

  def edit
    @slideshow = Slideshow.find(params[:id])
  end

  def create
    @slideshow = Slideshow.new(params[:slideshow])
    if @slideshow.save
      flash[:notice] = "Slideshow Created"
      redirect_to admin_slideshows_url
    else
      respond_with @slideshow
    end
  end

  def update
    @slideshow = Slideshow.find(params[:id])
    @slideshow.update_attributes(params[:slideshow])
    respond_with @slideshow, :location => admin_slideshows_url
  end

  def destroy
    @slideshow = Slideshow.find(params[:id])
    @slideshow.destroy
    respond_with @slideshow, :location => admin_slideshows_url
  end

  def sortable
    @slideshows = Slideshow.all
    @slideshows.each do |slideshow|
      slideshow.position = params['slideshow'].index(slideshow.id.to_s) + 1
      slideshow.save
    end
    render :nothing => true
  end
end
