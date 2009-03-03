class CmsSnippet < ActiveRecord::Base
  
  belongs_to :cms_page, :through => :cms_snippets
  
end
