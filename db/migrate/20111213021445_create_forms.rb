class CreateForms < ActiveRecord::Migration
  def self.up
    create_table :forms do |t|
      t.integer :position
      
      t.timestamps
    end
    create_table :form_items do |t|
      t.integer :form_id
      
      t.integer :position
      t.integer :score
      t.boolean :checked
      t.text    :content
      t.string  :item_type
      
      t.timestamps
    end
    
  end

  def self.down
    drop_table :forms
    drop_table :form_items
  end
  
end
