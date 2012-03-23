class Admin::Forms::RegistrationsController < AdminController
  
  def index
    respond_with @registrations = Registration.paginate(:page => params[:page], :per_page => 20)
  end
  
  def show
    respond_with @registration = Registration.find(params[:id])
  end
  
  def new
    respond_with @registration = Registration.new
  end
  
  def edit
    @registration = Registration.find(params[:id])
  end
  
  def create
    @registration = Registration.create!
    
    if @registration.update_attributes(params[:registration])
      redirect_to admin_forms_registrations_url
      mail(:to => "blake@hilscher.ca", :subject => "#{@registration.first_name_content}")
    else
      @registration.destroy
      respond_with @registration
    end
  end
  
  def update
    @registration = Registration.find(params[:id])
    @registration.update_attributes(params[:registration])
    respond_with @registration, :location => admin_forms_registrations_url
  end
  
  def destroy
    @registration = Registration.find(params[:id])
    @registration.destroy
    respond_with @registration, :location => admin_forms_registrations_url
  end
  
  def sortable
    @registrations = Registration.all
    @registrations.each do |registration|
      registration.position = params['registration'].index(registration.id.to_s) + 1
      registration.save
    end
    render :nothing => true
  end

end
