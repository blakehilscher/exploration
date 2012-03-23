class SlidePhoto < ActiveRecord::Base
  belongs_to  :slide
  mount_uploader :slide, SlideUploader, :mount_on => :image
  
  default_scope :order => "position ASC"
  attr_accessible :title, :content, :link, :slide, :remote_slide_url
  
  validates :slide_id, :presence => true
  validates :slide, :presence => true
  
end