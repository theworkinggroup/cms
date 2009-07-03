class CmsCategory < ActiveRecord::Base
  
  # -- Relationships --------------------------------------------------------
  
  acts_as_tree
  has_many :items, :class_name => 'CmsCategoryItem', :dependent => :destroy
  
  # -- Validations ----------------------------------------------------------
  
  validates_presence_of :slug, :label
  validates_uniqueness_of :slug, :scope => :parent_id
  
  # -- Named Scopes ---------------------------------------------------------
  
  default_scope :order => 'label'

  # -- Callbacks ------------------------------------------------------------
  
  before_validation :set_slug_if_blank

  # -- Instance Methods -----------------------------------------------------
  
  def set_slug_if_blank
    self.slug = self.label.slugify if (self.slug.blank? && !self.label.blank?)
  end

  def self.categories_for_select(collection = CmsCategory.roots, level = 0)
    out = []
    collection.each do |category|
      out += [["#{". . " * level} #{category.label}", category.id]]
      out += self.categories_for_select(category.children, level+1) if category.children.count > 0
    end
    out
  end

end