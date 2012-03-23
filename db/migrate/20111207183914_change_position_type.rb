class ChangePositionType < ActiveRecord::Migration
  def self.up
    change_column :bios, :position, :integer
    change_column :quotations, :position, :integer
  end

  def self.down
    change_column :bios, :position, :string
    change_column :quotations, :position, :string
  end
end
