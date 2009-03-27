class CmsBlock < ActiveRecord::Base
  
  # -- Relationships --------------------------------------------------------
  
  belongs_to :cms_page
  
  # -- Validations ----------------------------------------------------------
  
  validates_presence_of :label
  validates_uniqueness_of :label, :scope => :cms_page_id
  
end
