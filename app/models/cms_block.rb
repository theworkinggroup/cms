class CmsBlock < ActiveRecord::Base
  
  # -- Relationships --------------------------------------------------------
  
  belongs_to :cms_page
  
  # -- Validations ----------------------------------------------------------
  
  validates_presence_of :label, :cms_page_id, :block_type
  validates_uniqueness_of :label, :scope => :cms_page_id
  
end
