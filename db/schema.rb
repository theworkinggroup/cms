# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090303165425) do

  create_table "cms_blocks", :force => true do |t|
    t.integer  "cms_page_id"
    t.string   "label"
    t.string   "block_type"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_blocks", ["cms_page_id", "label"], :name => "index_cms_blocks_on_cms_page_id_and_label"

  create_table "cms_layouts", :force => true do |t|
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

  create_table "cms_pages", :force => true do |t|
    t.integer  "cms_layout_id"
    t.integer  "parent_id"
    t.integer  "redirect_to_page_id"
    t.string   "label"
    t.string   "slug"
    t.string   "full_path"
    t.integer  "children_count",      :default => 0,    :null => false
    t.integer  "position",            :default => 0,    :null => false
    t.boolean  "is_published",        :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_pages", ["full_path"], :name => "index_cms_pages_on_full_path"
  add_index "cms_pages", ["parent_id"], :name => "index_cms_pages_on_parent_id"
  add_index "cms_pages", ["slug"], :name => "index_cms_pages_on_slug"

  create_table "cms_snippets", :force => true do |t|
    t.string   "label"
    t.text     "content"
    t.integer  "position",   :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_snippets", ["label"], :name => "index_cms_snippets_on_label"

end
