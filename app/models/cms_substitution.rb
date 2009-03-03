class CmsSubstitution < ActiveRecord::Base
  
  belongs_to :cms_page
  belongs_to :cms_snippet
  
end
