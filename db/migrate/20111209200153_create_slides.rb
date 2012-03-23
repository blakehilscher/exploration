class CreateSlides < ActiveRecord::Migration
  def self.up
    create_table :slides do |t|
      t.integer :slideshow_id
      
      t.integer :position
      t.string  :title
      t.string  :link
      t.text    :content
      
      t.timestamps
    end
  end

  def self.down
    drop_table :slides
  end
end
