class CmsPage < ActiveRecord::Base
  
  attr_accessor :rendered_content
  
  # -- Relationships --------------------------------------------------------
  
  acts_as_tree :counter_cache => :children_count
  
  belongs_to  :cms_layout
  has_many    :cms_blocks,
    :dependent    => :destroy
  belongs_to  :redirect_to_page,
    :class_name   => 'CmsPage',
    :foreign_key  => :redirect_to_page_id
  has_one :redirected_from_page,
    :class_name   => 'CmsPage',
    :foreign_key  => :redirect_to_page_id
  
  #-- Validations -----------------------------------------------------------
  
  validates_presence_of   :cms_layout_id,
    :unless => lambda{|p| p.redirect_to_page}
  validates_presence_of   :label
  validates_presence_of   :slug,
    :unless => lambda{|p| CmsPage.count == 0 || p == CmsPage.root}
  validates_format_of     :slug,
    :with   => /^\w[a-z0-9_-]*$/i,
    :unless => lambda{|p| CmsPage.count == 0 || p == CmsPage.root}
  validates_uniqueness_of :full_path
  
  validate :validate_redirect_to
  
  # -- AR Callbacks ---------------------------------------------------------
  
  before_validation :assign_full_path
  after_save        :sync_child_slugs
  
  # -- Scopes ---------------------------------------------------------------
  
  default_scope :order => 'position ASC'
  
  named_scope :published,
    :conditions => {:is_published => true}
  
  # -- Instance Methods -----------------------------------------------------
  
  def content
    page_content = cms_layout.content
    cms_layout.tags(:page => self).sort_by{|t| t.class.render_priority}.each do |tag|
      page_content.gsub!(tag.regex, tag.render)
    end
    page_content
  end
  
  def blocks=(blocks)
    blocks.each do |label, params|
      if self.new_record? 
        self.cms_blocks.build({:label => label}.merge(params))
      else
        if block = self.cms_blocks.with_label(label).try(:first)
          block.update_attributes!(params)
        else
          self.cms_blocks.create!({:label => label}.merge(params))
        end
      end
    end
  end
  
  def pages_for_select(page = CmsPage.root, level = 0, exclude_self = false)
    page ||= CmsPage.root
    return [] if !page || (page == self && exclude_self)
    out = [["#{". . " * level} #{page.label}", page.id]]
    page.children.each do |child|
      if child.children.count > 0
        out += pages_for_select(child, level + 1, exclude_self)
      else
        unless (child == self && exclude_self)
          out += [["#{". . " * (level + 1)} #{child.label}", child.id]]
        end
      end
    end
    out
  end
  
  def full_path
    "/#{read_attribute(:full_path)}"
  end
  
protected
  
  def assign_full_path
    self.full_path = (self.ancestors.reverse.collect{|p| p.slug}.compact + [self.slug]).join('/')
  end
  
  def validate_redirect_to
    if self.redirect_to_page && (self == self.redirect_to_page || self.redirect_to_page.redirect_to_page)
      self.errors.add(:redirect_to_page_id) 
    end
  end
  
  def sync_child_slugs
    if slug_changed?
      children.each do |child|
        child.save!
      end
    end
  end
  
  def method_missing(method)
    self.cms_blocks.select{|b| "cms_block_#{b.label}" == method.to_s}.first || super
  end
end