class AddTitleToQuotations < ActiveRecord::Migration
  def self.up
    add_column :quotations, :title, :string
  end

  def self.down
    remove_column :quotations, :title
  end
end
