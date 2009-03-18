class CmsPage < ActiveRecord::Base
  
  # -- Relationships --------------------------------------------------------
  
  belongs_to :cms_layout
  has_many :cms_blocks, :dependent => :destroy
  
  #-- Validations -----------------------------------------------------------
  
  validates_presence_of :cms_layout_id
  validates_uniqueness_of :full_path
  
  # -- Instance Methods -----------------------------------------------------
  
  def content
    page_content = self.cms_layout.content
    
    # block replacements
    self.cms_blocks.each do |block|
      page_content.gsub!(/\{\{\s*cms_block:#{block.label}:.*?s*\}\}/, block.content)
    end
    
    # snippet replacements
    CmsSnippet.all.each do |snippet|
      page_content.gsub!(/\{\{\s*cms_snippet:#{snippet.label}\s*\}\}/, snippet.content)
    end
    
    page_content
  end
  
end
