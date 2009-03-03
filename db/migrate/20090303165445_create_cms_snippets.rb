class CreateCmsSnippets < ActiveRecord::Migration
  def self.up
    create_table :cms_snippets do |t|
      t.string :label
      t.text :content
      t.timestamps
    end
    
    add_index :cms_snippets, :label
  rescue
    self.down
    raise
  end

  def self.down
    drop_table :cms_snippets
  end
end
