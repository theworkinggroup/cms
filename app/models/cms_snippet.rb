class CmsSnippet < ActiveRecord::Base
  
  # -- Validations ----------------------------------------------------------
  
  validates_presence_of :label
  validates_uniqueness_of :label
    
end
