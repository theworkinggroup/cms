class CreateCms < ActiveRecord::Migration
  def self.up
    
    create_table :cms_layouts do |t|
      t.integer :parent_id
      t.string  :label
      t.text    :content
      t.string  :app_layout
      t.integer :children_count,  :null => false, :default => 0
      t.boolean :is_extendable,   :null => false, :default => false
      t.integer :position,        :null => false, :default => 0
      t.timestamps
    end
    add_index :cms_layouts, :parent_id
    add_index :cms_layouts, :label
    
    
    create_table :cms_pages do |t|
      t.integer   :cms_layout_id
      t.integer   :parent_id
      t.integer   :redirect_to_page_id
      t.string    :label
      t.string    :slug
      t.string    :full_path
      t.integer   :children_count,  :null => false, :default => 0
      t.integer   :position,        :null => false, :default => 0
      t.datetime  :published_at
      t.datetime  :unpublished_at
      t.timestamps
    end
    add_index :cms_pages, :parent_id
    add_index :cms_pages, :slug
    add_index :cms_pages, :full_path, :unique => true
    
    
    create_table :cms_snippets do |t|
      t.string  :label
      t.text    :content
      t.timestamps
    end
    add_index :cms_snippets, :label, :unique => true
    
    
    create_table :cms_blocks do |t|
      t.integer   :cms_page_id
      t.string    :label
      t.text      :content_text
      t.string    :content_string
      t.integer   :content_integer
      t.boolean   :content_boolean
      t.datetime  :content_datetime
      t.timestamps
    end
    add_index :cms_blocks, [:cms_page_id, :label], :unique => true
    add_index :cms_blocks, [:cms_page_id, :label, :content_string], :unique => true
    add_index :cms_blocks, [:cms_page_id, :label, :content_integer], :unique => true
    add_index :cms_blocks, [:cms_page_id, :label, :content_boolean], :unique => true
    add_index :cms_blocks, [:cms_page_id, :label, :content_datetime], :unique => true        

  end
  
  def self.down
    drop_table :cms_layouts
    drop_table :cms_pages
    drop_table :cms_snippets
    drop_table :cms_blocks
  end
end
