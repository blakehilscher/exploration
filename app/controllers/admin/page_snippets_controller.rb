class Admin::PageSnippetsController < AdminController
  
  before_filter :load_dependencies
  
  def load_dependencies
    @page = Page.find params[:page_id]
  end
  
  def index
    Rails.logger.debug y @page
    respond_with @page
  end

  def show
    respond_with @snippet = @page.snippets.find(params[:id])
  end
  
  def new
    respond_with @snippet = @page.snippets.new
  end
  
  def edit
    @snippet = @page.snippets.find(params[:id])
  end
  
  def create
    @snippet = @page.snippets.new(params[:page_snippet])
    
    if @snippet.save
      redirect_to admin_page_page_snippets_url(@page)
    else
      respond_with @snippet
    end
  end
  
  def update
    @snippet = @page.snippets.find(params[:id])
    @snippet.update_attributes(params[:page_snippet])
    respond_with @snippet, :location => admin_pages_url
  end
  
  def destroy
    @snippet = @page.snippets.find(params[:id])
    @snippet.destroy
    redirect_to admin_page_page_snippets_url(@page)
  end
  
  def sortable
    @snippets = @page.snippets.all
    @snippets.each do |snippet|
      snippet.position = params['snippet'].index(snippet.id.to_s) + 1
      snippet.save
    end
    render :nothing => true
  end

end
