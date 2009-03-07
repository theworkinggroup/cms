class CreateCmsBlocks < ActiveRecord::Migration
  def self.up
    create_table :cms_blocks do |t|
      t.integer :cms_page_id
      t.string :label 
      t.string :block_type
      t.text :content
      t.timestamps
    end
  end

  def self.down
    drop_table :cms_blocks
  end
end
