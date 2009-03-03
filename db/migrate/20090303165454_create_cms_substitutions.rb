class CreateCmsSubstitutions < ActiveRecord::Migration
  def self.up
    create_table :cms_substitutions do |t|
      t.integer :page_id
      t.integer :snippet_id
      t.timestamps
    end
    
    add_index :cms_substitutions, [:page_id, :snippet_id], :unique => true
  
  rescue
    self.down
    raise
  end

  def self.down
    drop_table :cms_substitutions
  end
end
