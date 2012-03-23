class AddImageToBios < ActiveRecord::Migration
  def self.up
    add_column :bios, :image, :string
  end

  def self.down
    remove_column :bios, :image
  end
end
