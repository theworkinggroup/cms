class CmsPage < ActiveRecord::Base
  
  belongs_to :cms_layout
  has_many :cms_blocks
  
  def content
    page_content = self.cms_layout.content
    self.cms_blocks.each do |block|
      page_content.gsub!(/\{\{\s*cms_block:#{block.label}:.*?s*\}\}/, block.content)
    end
    page_content
  end
  
end
