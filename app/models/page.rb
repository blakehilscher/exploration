class Page < ActiveRecord::Base
  has_many :snippets, :class_name => 'PageSnippet', :dependent => :destroy

  validates_uniqueness_of :slug
  
  after_create :create_default_snippets
  
  def create_default_snippets
    snippets.create!({:slug => 'content', :title => 'Content'})
    snippets.create!({:slug => 'aside', :title => 'Aside'})
  end
  
  def self.slug(search)
    where(:slug => search).first
  end
  
end
