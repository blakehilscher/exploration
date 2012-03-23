class CreatePageSnippets < ActiveRecord::Migration
  def self.up
    create_table :page_snippets do |t|
      t.integer :page_id
      t.text :content
      t.string :title
      t.string :image
      t.string :slug
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :page_snippets
  end
end