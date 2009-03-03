class CmsPage < ActiveRecord::Base
  
  belongs_to :cms_layout
  has_many :cms_snippets, :through => :cms_substitutions
  
end
