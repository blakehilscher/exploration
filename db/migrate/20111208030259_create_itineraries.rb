class CreateItineraries < ActiveRecord::Migration
  def self.up
    create_table :itineraries do |t|
      t.string :title
      t.text :content
      t.string :image
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :itineraries
  end
end