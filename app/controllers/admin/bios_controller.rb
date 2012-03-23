class Admin::BiosController < AdminController
  
  def index
    respond_with @bios = Bio.all
  end

  def show
    respond_with @bio = Bio.find(params[:id])
  end
  
  def new
    respond_with @bio = Bio.new
  end
  
  def edit
    @bio = Bio.find(params[:id])
  end
  
  def create
    @bio = Bio.new(params[:bio])
    
    if @bio.save
      redirect_to admin_bios_url
    else
      respond_with @bio
    end
  end
  
  def update
    @bio = Bio.find(params[:id])
    @bio.update_attributes(params[:bio])
    respond_with @bio, :location => admin_bios_url
  end
  
  def destroy
    @bio = Bio.find(params[:id])
    @bio.destroy
    respond_with @bio, :location => admin_bios_url
  end
  
  def sortable
    @bios = Bio.all
    @bios.each do |bio|
      bio.position = params['bio'].index(bio.id.to_s) + 1
      bio.save
    end
    render :nothing => true
  end

end
