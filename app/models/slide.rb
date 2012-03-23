class Slide < ActiveRecord::Base
  belongs_to  :slideshow
  has_many    :slide_photos, :dependent => :destroy
  
  default_scope :order => "position ASC"
  
  validates :slideshow_id, :presence => true
  
  def photos=(*args)
    self.send('slide_photos=', args)
  end  
  def photos
    self.slide_photos
  end
  
end