class CreateSlidePhotos < ActiveRecord::Migration
  def self.up
    create_table :slide_photos do |t|
      t.integer :slide_id
      
      t.integer :position
      t.string  :title
      t.string  :image
      t.string  :link
      t.text    :content

      t.timestamps
    end
  end

  def self.down
    drop_table :slide_photos
  end
end
