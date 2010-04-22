class CreateCms < ActiveRecord::Migration
  def self.up
    create_table :cms_sites do |t|
      t.string :label
      t.integer :cms_page_id
    end
    
    add_index :cms_sites, :label
    add_index :cms_sites, :cms_page_id

    create_table :cms_site_hostnames do |t|
      t.integer :cms_site_id, :null => false
      t.string :hostname, :null => false
      t.string :environment
      t.boolean :redirect, :null => false, :default => false
    end
    
    add_index :cms_site_hostnames, [ :environment, :hostname ]
    add_index :cms_site_hostnames, [ :cms_site_id, :hostname ]
    
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
      t.integer   :children_count,  :null => false, :default => 0
      t.integer   :position,        :null => false, :default => 0
      t.boolean   :site_root, :null => false, :default => false
      t.datetime  :published_at
      t.datetime  :unpublished_at
      t.timestamps
    end
    add_index :cms_pages, :parent_id
    add_index :cms_pages, :slug
    add_index :cms_pages, [ :cms_site_id, :full_path ], :unique => true

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
    add_index :cms_blocks, [:cms_page_id, :label, :content_string], :unique => true
    add_index :cms_blocks, [:cms_page_id, :label, :content_integer], :unique => true
    add_index :cms_blocks, [:cms_page_id, :label, :content_boolean], :unique => true
    add_index :cms_blocks, [:cms_page_id, :label, :content_datetime], :unique => true

    execute "INSERT INTO cms_blocks (id, cms_page_id, label, content_text) VALUES (1, 1, 'default', 'Default home page')"

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
  end
end
