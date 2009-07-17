class CmsAttachmentCategorization < ActiveRecord::Base
  
  # -- Relationships --------------------------------------------------------
  belongs_to :cms_attachment
  belongs_to :cms_category
  
  # -- Validations ----------------------------------------------------------
  validates_presence_of :cms_attachment_id,
                        :cms_category_id
                        
  validates_uniqueness_of :cms_attachment_id, :scope => :cms_category_id
  
  # -- AR Callbacks ---------------------------------------------------------
  after_save :create_parent_categorization
  after_destroy :destroy_children_categorizations

protected

  def create_parent_categorization
    return unless cms_category.parent
    
    params = {
      :cms_category_id    => cms_category.parent_id,
      :cms_attachment_id  => cms_attachment.id
    }
    CmsAttachmentCategorization.create!(params) unless CmsAttachmentCategorization.exists?(params)
  end
  
  def destroy_children_categorizations
    return if cms_category.children.blank?
    
    cms_category.children.each do |c|
      cms_attachment.cms_attachment_categorizations.first(:conditions => {:cms_category_id => c.id }).try(:destroy)
    end
  end
end
