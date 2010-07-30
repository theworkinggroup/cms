# This file is auto-generated from the current state of the database. Instead 
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your 
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100730194652) do

  create_table "cms_blocks", :force => true do |t|
    t.integer  "cms_page_id"
    t.string   "label"
    t.text     "content_text"
    t.string   "content_string"
    t.integer  "content_integer"
    t.boolean  "content_boolean"
    t.datetime "content_datetime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_blocks", ["cms_page_id", "label"], :name => "index_cms_blocks_on_cms_page_id_and_label", :unique => true
  add_index "cms_blocks", ["label", "content_boolean"], :name => "index_cms_blocks_on_label_and_content_boolean"
  add_index "cms_blocks", ["label", "content_datetime"], :name => "index_cms_blocks_on_label_and_content_datetime"
  add_index "cms_blocks", ["label", "content_integer"], :name => "index_cms_blocks_on_label_and_content_integer"
  add_index "cms_blocks", ["label", "content_string"], :name => "index_cms_blocks_on_label_and_content_string"

  create_table "cms_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "slug"
    t.string   "label"
    t.text     "description"
    t.integer  "children_count", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_categories", ["parent_id", "slug"], :name => "index_cms_categories_on_parent_id_and_slug"
  add_index "cms_categories", ["slug"], :name => "index_cms_categories_on_slug"

  create_table "cms_layouts", :force => true do |t|
    t.integer  "cms_site_id"
    t.integer  "parent_id"
    t.string   "label"
    t.text     "content"
    t.string   "app_layout"
    t.integer  "children_count", :default => 0,     :null => false
    t.boolean  "is_extendable",  :default => false, :null => false
    t.integer  "position",       :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_layouts", ["label"], :name => "index_cms_layouts_on_label"
  add_index "cms_layouts", ["parent_id"], :name => "index_cms_layouts_on_parent_id"

  create_table "cms_page_categorizations", :force => true do |t|
    t.integer  "cms_category_id"
    t.integer  "cms_page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_page_categorizations", ["cms_category_id", "cms_page_id"], :name => "index_page_categorizations_on_category_id_and_page_id", :unique => true

  create_table "cms_pages", :force => true do |t|
    t.integer  "cms_site_id"
    t.integer  "cms_layout_id"
    t.integer  "parent_id"
    t.integer  "redirect_to_page_id"
    t.string   "label"
    t.string   "slug"
    t.string   "full_path"
    t.integer  "children_count",      :default => 0,     :null => false
    t.integer  "position",            :default => 0,     :null => false
    t.boolean  "published",           :default => true,  :null => false
    t.boolean  "excluded_from_nav",   :default => false, :null => false
    t.boolean  "site_root",           :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_pages", ["cms_site_id", "full_path"], :name => "index_cms_pages_on_cms_site_id_and_full_path", :unique => true
  add_index "cms_pages", ["excluded_from_nav", "parent_id"], :name => "index_cms_pages_on_excluded_from_nav_and_parent_id"
  add_index "cms_pages", ["parent_id", "slug"], :name => "index_cms_pages_on_parent_id_and_slug"
  add_index "cms_pages", ["published", "full_path"], :name => "index_cms_pages_on_published_and_full_path"

  create_table "cms_sites", :force => true do |t|
    t.string "label"
    t.string "hostname"
  end

  add_index "cms_sites", ["hostname"], :name => "index_cms_sites_on_hostname", :unique => true
  add_index "cms_sites", ["label"], :name => "index_cms_sites_on_label"

  create_table "cms_snippets", :force => true do |t|
    t.string   "label"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_snippets", ["label"], :name => "index_cms_snippets_on_label", :unique => true

end
