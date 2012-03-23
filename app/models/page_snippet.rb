class PageSnippet < ActiveRecord::Base
  belongs_to :page
  mount_uploader :image, ImageUploader
    
  validates_uniqueness_of :slug, :scope => :page_id
  validates :page_id, :presence => true
  def self.slug(search)
    where(:slug => search).first
  end  
end
