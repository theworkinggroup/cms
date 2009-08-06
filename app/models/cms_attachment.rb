class CmsAttachment < ActiveRecord::Base

  # -- Relationships --------------------------------------------------------
  
  has_attached_file :file, ComfortableMexicanSofa::Config.paperclip_options
  acts_as_categorized
  
  # -- Validations ----------------------------------------------------------
  
  validates_attachment_presence :file
  validates_presence_of :label

  # -- Named Scopes ----------------------------------------------------------

  default_scope :order => 'created_at DESC'

end