class CmsLayout < ActiveRecord::Base
  
  # -- Relationships --------------------------------------------------------
  
  acts_as_tree
  has_many :cms_pages
  
  # -- Validations ----------------------------------------------------------
  
  # TODO: If layout has parent layout, make sure that parent layout has a default block.
  validates_presence_of :label
    
  # -- Instance methods -----------------------------------------------------
  
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
