class Admin::ItinerariesController < AdminController
  
  def index
    respond_with @itineraries = Itinerary.all
  end

  def show
    respond_with @itinerary = Itinerary.find(params[:id])
  end
  
  def new
    respond_with @itinerary = Itinerary.new
  end
  
  def edit
    @itinerary = Itinerary.find(params[:id])
  end
  
  def create
    @itinerary = Itinerary.new(params[:itinerary])
    
    if @itinerary.save
      redirect_to admin_itineraries_url
    else
      respond_with @itinerary
    end
  end
  
  def update
    @itinerary = Itinerary.find(params[:id])
    @itinerary.update_attributes(params[:itinerary])
    respond_with @itinerary, :location => admin_itineraries_url
  end
  
  def destroy
    @itinerary = Itinerary.find(params[:id])
    @itinerary.destroy
    respond_with @itinerary, :location => admin_itineraries_url
  end
  
  def sortable
    @itineraries = Itinerary.all
    @itineraries.each do |itinerary|
      itinerary.position = params['itinerary'].index(itinerary.id.to_s) + 1
      itinerary.save
    end
    render :nothing => true
  end

end
