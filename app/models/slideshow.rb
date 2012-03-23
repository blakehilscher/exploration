class Slideshow < ActiveRecord::Base
  has_many :slides, :dependent => :destroy
  
  default_scope :order => "position ASC"
  
  
  def self.slug(search)
    where(:slug => search).first
  end
  
end