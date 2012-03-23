class Registration < Form
  
  validates :email_content, :presence => true, 
    :length => {:minimum => 3, :maximum => 254},
    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i},
    :on => :update
  
  validates :first_name_content, :presence => true, :on => :update
  validates :last_name_content, :presence => true, :on => :update
  validates :birthday_content, :presence => true, :on => :update
  validates :citizenship_content, :presence => true, :on => :update
  
  validates :street_content, :presence => true, :on => :update
  validates :city_content, :presence => true, :on => :update
  validates :province_content, :presence => true, :on => :update
  validates :postal_content, :presence => true, :on => :update
  validates :country_content, :presence => true, :on => :update
  
  validate :phone_present?, :on => :update
  
  validates :allergy_content, :presence => true, :on => :update
  validates :medication_content, :presence => true, :on => :update

  def phone_present?
    present = false;
    %w(phone_home_content phone_mobile_content phone_work_content).each do |attr|
      present = true unless self.send(attr).blank?
    end
    unless present
      errors.add(:phone_home_content, "You must provide at least one phone number.") 
      errors.add(:phone_mobile_content, "You must provide at least one phone number.") 
      errors.add(:phone_work_content, "You must provide at least one phone number.") 
    end
  end
  
  validates :hear_about_content, :presence => true, :on => :update
  
  validates :travel_package_content, :presence => true, :on => :update
  validates :meeting_time_content, :presence => true, :on => :update
  validates :meeting_day_content, :presence => true, :on => :update
  
    
  def configure
    @config = {
      :title              => {:count => 1},
      :last_name          => {:count => 1},
      :first_name         => {:count => 1},
      :citizenship        => {:count => 1},
      :street             => {:count => 1},
      :city               => {:count => 1},
      :province           => {:count => 1},
      :postal             => {:count => 1},
      :country            => {:count => 1},
      :phone_home         => {:count => 1},
      :phone_mobile       => {:count => 1},
      :phone_work         => {:count => 1},
      :occupation         => {:count => 1},
      :birthday           => {:count => 1},
      :tshirt             => {:count => 1},
      :allergy            => {:count => 1},
      :allergy_list       => {:count => 1},
      :medical_conditions => {:count => 12},
      :medical_histories  => {:count => 6},
      :medications        => {:count => 1},
      :medication_items   => {:count => 4},
      :medical_treatments => {:count => 6},
      :diet_restrictions  => {:count => 1},
      :diet_other         => {:count => 1},
      :hear_about         => {:count => 1},
      :travel_package     => {:count => 1},
      :meeting_time       => {:count => 1},
      :meeting_day        => {:count => 1},
    }
    super
  end
end