class RegistrationsController < ApplicationController
  
  def new
    respond_with @registration = Registration.new
  end
  
  def create
    @registration = Registration.create!
    if @registration.update_attributes(params[:registration])
      redirect_to pages_thanks_url
      #mail(:to => "blake@hilscher.ca", :subject => "#{@registration.first_name_content}")
    else
      @registration.destroy
      respond_with @registration
    end
  end
  
end
