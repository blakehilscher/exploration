class Photo < ActiveRecord::Base
  default_scope :order => "position ASC"
  attr_accessible :title, :description, :image, :remote_image_url
  mount_uploader :image, ImageUploader
end