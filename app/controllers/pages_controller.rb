class PagesController < ApplicationController
  before_filter :load_dependencies

  def load_dependencies
    @quotations = Quotation.all
    @page = Page.slug params[:action]
    unless @page.blank?
      @content = @page.snippets.slug 'content'
    end
  end
  
  def home
    @slideshow = Slideshow.slug 'home'
  end

  def coming_soon
  end

  def contact_us
    @contact = @page.snippets.slug 'contact'
    @usa = @page.snippets.slug 'usa'
    @canada = @page.snippets.slug 'canada'
  end
  
  def fitness
    @notice = @page.snippets.slug 'notice'
  end
  
  def photos
    @photos = Photo.paginate(:page => params[:page],:per_page => 12)
  end
  
  def our_team
    @bios = Bio.all
  end
  
  def our_tours
  end
  
  def packages
  end
  
  def trip_itinerary
    @itineraries = Itinerary.all
  end
  
  def newsletter
  end
  
  def thanks
  end
  
end


