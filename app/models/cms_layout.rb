class CmsLayout < ActiveRecord::Base
  
  acts_as_tree
  
  has_many :cms_pages
  
  def content
    if parent
      parent.content.gsub(/\{\{\s*cms_block:default:.*?\}\}/, self.read_attribute(:content))
    else
      self.read_attribute(:content)
    end
  end
  
  def blocks    
    self.content.scan(/\{\{\s*cms_block:(.*?)\s*\}\}/).flatten
  end
  
  
end
