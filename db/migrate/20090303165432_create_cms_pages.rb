class CreateCmsPages < ActiveRecord::Migration
  def self.up
    create_table :cms_pages do |t|
      t.integer :cms_layout_id
      t.integer :parent_id
      t.integer :redirect_to_page_id
      t.string :label
      t.string :slug
      t.string :full_path
      t.integer :children_count,  :null => false, :default => 0
      t.integer :position,        :null => false, :default => 0
      t.boolean :is_published,    :null => false, :default => true
      t.timestamps
    end
    
    add_index :cms_pages, :parent_id
    add_index :cms_pages, :slug
    add_index :cms_pages, :full_path
    
  rescue
    self.down
    raise
  end

  def self.down
    drop_table :cms_pages
  end
end
