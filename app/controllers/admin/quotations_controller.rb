class Admin::QuotationsController < AdminController
  
  def index
    respond_with @quotations = Quotation.all
  end

  def show
    respond_with @quotation = Quotation.find(params[:id])
  end
  
  def new
    respond_with @quotation = Quotation.new
  end
  
  def edit
    @quotation = Quotation.find(params[:id])
  end
  
  def create
    @quotation = Quotation.new(params[:quotation])
    
    if @quotation.save
      redirect_to edit_admin_quotation_url(@quotation)
    else
      respond_with @quotation
    end
  end
  
  def update
    @quotation = Quotation.find(params[:id])
    @quotation.update_attributes(params[:quotation])
    respond_with @quotation, :location => edit_admin_quotation_url
  end
  
  def destroy
    @quotation = Quotation.find(params[:id])
    @quotation.destroy
    respond_with @quotation, :location => admin_quotations_url
  end
  
  def sortable
    @quotations = Quotation.all
    @quotations.each do |quotation|
      quotation.position = params['quotation'].index(quotation.id.to_s) + 1
      quotation.save
    end
    render :nothing => true
  end
  
end
