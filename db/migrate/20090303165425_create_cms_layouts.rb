class CreateCmsLayouts < ActiveRecord::Migration
  def self.up
    create_table :cms_layouts do |t|
      t.integer :parent_id
      t.string :label
      t.text :content
      t.timestamps
    end
    
    add_index :cms_layouts, :parent_id
    add_index :cms_layouts, :label
  rescue
    self.down
    raise
  end

  def self.down
    drop_table :cms_layouts
  end
end
