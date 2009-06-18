class CmsAttachment < ActiveRecord::Base
  
  has_attached_file :file, ComfortableMexicanSofa::Config.paperclip_options
  validates_attachment_presence :file
  
  validates_presence_of :label
  
end