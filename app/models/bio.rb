class Bio < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  default_scope :order => "position ASC"
end
