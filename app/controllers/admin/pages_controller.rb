class Admin::PagesController < AdminController
  
  def index
    respond_with @pages = Page.all
  end

  def show
    respond_with @page = Page.find(params[:id])
  end
  
  def new
    respond_with @page = Page.new
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def create
    @page = Page.new(params[:page])
    
    if @page.save
      redirect_to admin_pages_url
    else
      respond_with @page
    end
  end
  
  def update
    @page = Page.find(params[:id])
    @page.update_attributes(params[:page])
    respond_with @page, :location => admin_pages_url
  end
  
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    respond_with @page, :location => admin_pages_url
  end
  
  def sortable
    @pages = Page.all
    @pages.each do |page|
      page.position = params['page'].index(page.id.to_s) + 1
      page.save
    end
    render :nothing => true
  end

end
