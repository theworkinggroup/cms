class CreateCmsStructure < ActiveRecord::Migration
  def self.up
    create_table :cms_layouts do |t|
      t.integer :parent_id
      t.string :label
      t.text :content
      t.string :app_layout
      t.integer :children_count,  :null => false, :default => 0
      t.boolean :is_extendable,   :null => false, :default => false
      t.integer :position,        :null => false, :default => 0
      t.timestamps
    end
    
    add_index :cms_layouts, :parent_id
    add_index :cms_layouts, :label
    
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
    
    create_table :cms_snippets do |t|
      t.string :label
      t.text :content
      t.integer :position, :null => false, :default => 0
      t.timestamps
    end
    
    add_index :cms_snippets, :label
    
    create_table :cms_blocks do |t|
      t.integer :cms_page_id
      t.string :label 
      t.string :block_type
      t.text :content
      t.timestamps
    end
    
    add_index :cms_blocks, [:cms_page_id, :label]
    
  rescue
    self.down
    raise
  end

  def self.down
    drop_table :cms_layouts
    drop_table :cms_pages
    drop_table :cms_snippets
    drop_table :cms_blocks
  end
end
