class CmsSiteHostname < ActiveRecord::Base
  # -- Relationships --------------------------------------------------------

  belongs_to :site,
    :class_name => 'CmsSite',
    :foreign_key => :cms_site_id
  
  # -- Validations ----------------------------------------------------------

  validates_presence_of :hostname
  validates_uniqueness_of :hostname
  
  # -- Scopes ---------------------------------------------------------------

  default_scope :order => 'hostname ASC'
  
  # -- Class Methods --------------------------------------------------------

  # -- Instance Methods -----------------------------------------------------
  
protected
  # ...
end
