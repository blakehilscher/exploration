class AddPositionToQuotations < ActiveRecord::Migration
  def self.up
    add_column :quotations, :position, :string
  end

  def self.down
    remove_column :quotations, :position
  end
end
