class AddPositionToBios < ActiveRecord::Migration
  def self.up
    add_column :bios, :position, :string
  end

  def self.down
    remove_column :bios, :position
  end
end
