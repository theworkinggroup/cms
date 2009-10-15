class CmsPage < ActiveRecord::Base
  
  attr_accessor :rendered_content
  
  # -- Relationships --------------------------------------------------------
  acts_as_tree :counter_cache => :children_count
  acts_as_published
  acts_as_categorized
  
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
  after_save        :save_blocks,
                    :sync_child_slugs
  
  # -- Scopes ---------------------------------------------------------------
  default_scope :order => 'position ASC'
  named_scope :sections,
    :conditions => {:is_section => true}
    
  # -- Class Methods --------------------------------------------------------
  def self.[](slug)
    CmsPage.find_by_slug!(slug)
  end
    
  # -- Instance Methods -----------------------------------------------------
  def content
    # TODO: Add column to cache the render output. pointless to run it all the time
    render_content
  end
  
  # FIX: Recursive Tag/Content Replacement
  # Works, but potentionally dangerous and not particularly efficient
  def render_content(content = nil)
    content = cms_layout.content.dup if !content
    while (!(tags = CmsTag::parse_tags(content, :page => self).sort_by{|t| t.class.render_priority}).blank?)
      tags.each do |tag|
        content.gsub!(tag.regex) { tag.render }
      end
    end
    content
  end
  
  def blocks=(blocks)
    blocks.each do |label, params|
      if !self.new_record? && !(block = self.cms_blocks.select{|b| b.label == label}.first).blank?
        block.attributes = params
      else
        self.cms_blocks.build({:label => label}.merge(params))
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
  
  def cms_block_content(label, content)
    self.cms_blocks.select{|b| b.label.to_s == label.to_s}.first.try(content)
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
  
  def save_blocks
    self.cms_blocks.each do |b|
      b.save! if b.changed?
    end
  end
  
  def sync_child_slugs
    if slug_changed?
      children.each do |child|
        child.save!
      end
    end
  end
end