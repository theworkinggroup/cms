class CreateCms < ActiveRecord::Migration
  def self.up
    create_table :cms_sites do |t|
      t.string :label
      t.string :hostname
    end
    
    add_index :cms_sites, :label
    add_index :cms_sites, :hostname, :unique => true
    
    create_table :cms_layouts do |t|
      t.integer :cms_site_id
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
    
    execute "INSERT INTO cms_layouts (id, label, app_layout, content) VALUES (1, 'Default Layout', 'application', '{{cms_page_block:default:text}}')"
    
    create_table :cms_pages do |t|
      t.integer   :cms_site_id
      t.integer   :cms_layout_id
      t.integer   :parent_id
      t.integer   :redirect_to_page_id
      t.string    :label
      t.string    :slug
      t.string    :full_path
      t.integer   :children_count,    :null => false, :default => 0
      t.integer   :position,          :null => false, :default => 0
      t.boolean   :published,         :null => false, :default => true
      t.boolean   :excluded_from_nav, :null => false, :default => false
      t.boolean   :site_root,         :null => false, :default => false
      t.timestamps
    end
    add_index :cms_pages, [:parent_id, :slug]
    add_index :cms_pages, [ :cms_site_id, :full_path ], :unique => true
    add_index :cms_pages, [:published, :full_path]
    add_index :cms_pages, [:excluded_from_nav, :parent_id]

    execute "INSERT INTO cms_pages (id, cms_layout_id, label, slug, full_path) VALUES (1, 1, 'Default Page', NULL, '')"
    
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
    add_index :cms_blocks, [:label, :content_string]
    add_index :cms_blocks, [:label, :content_integer]
    add_index :cms_blocks, [:label, :content_boolean]
    add_index :cms_blocks, [:label, :content_datetime]        

    execute "INSERT INTO cms_blocks (id, cms_page_id, label, content_text) VALUES (1, 1, 'default', 'Default home page')"

    create_table :cms_categories do |t|
      t.integer :parent_id
      t.string  :slug
      t.string  :label
      t.text    :description
      t.integer :children_count,  :null => false, :default => 0
      t.timestamps
    end
    add_index :cms_categories, :slug
    add_index :cms_categories, [:parent_id, :slug]
    
    
    create_table :cms_page_categorizations do |t|
      t.integer :cms_category_id
      t.integer :cms_page_id
      t.timestamps
    end
    add_index :cms_page_categorizations, [:cms_category_id, :cms_page_id], :unique => true, 
      :name => 'index_page_categorizations_on_category_id_and_page_id' #auto-generated name was too long.


    create_table :cms_snippets do |t|
      t.string  :label
      t.text    :content
      t.timestamps
    end
    add_index :cms_snippets, :label, :unique => true
  end
  
  def self.down
    drop_table :cms_layouts
    drop_table :cms_pages
    drop_table :cms_snippets
    drop_table :cms_blocks
    drop_table :cms_sites
    drop_table :cms_categories
    drop_table :cms_page_categorizations
  end
end
