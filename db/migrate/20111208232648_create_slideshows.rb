class CreateSlideshows < ActiveRecord::Migration
  def self.up
    create_table :slideshows do |t|
      
      t.integer :position
      t.string  :title
      t.string  :link
      t.text    :content
      t.string  :slug
      
      t.timestamps
    end
  end

  def self.down
    drop_table :slideshows
  end
end