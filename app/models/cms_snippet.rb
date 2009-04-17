class CmsSnippet < ActiveRecord::Base
  
  # -- Validations ----------------------------------------------------------
  
  validates_presence_of   :label, 
                          :slug
  validates_uniqueness_of :slug
  validates_format_of     :slug,
    :with   => /^\w[a-z0-9_-]*$/i
  
  # -- Scopes ---------------------------------------------------------------
  
  default_scope :order => 'position ASC'
  
  # -- Class Methods --------------------------------------------------------
  
  def self.content_for(slug)
    s = find_by_slug(slug)
    s.blank? ? "{{ #{slug} }}" : s.content
  end
    
end
