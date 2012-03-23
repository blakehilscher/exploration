class CreateBios < ActiveRecord::Migration
  def self.up
    create_table :bios do |t|
      t.string :name
      t.string :title
      t.text :content
      t.string :filename

      t.timestamps
    end
  end

  def self.down
    drop_table :bios
  end
end
