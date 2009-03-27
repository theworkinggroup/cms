class CmsPage < ActiveRecord::Base
  
  # -- Relationships --------------------------------------------------------
  
  acts_as_tree :counter_cache => :children_count
  
  belongs_to :cms_layout
  has_many :cms_blocks, :dependent => :destroy
  
  #-- Validations -----------------------------------------------------------
  
  validates_presence_of :cms_layout_id
  validates_presence_of :slug, :unless => Proc.new{ CmsPage.count == 0 }
  validates_uniqueness_of :full_path
  
  
  # -- AR Callbacks ---------------------------------------------------------
  
  before_validation :assign_full_path
  
  # -- Instance Methods -----------------------------------------------------
  
  def content
    page_content = self.cms_layout.content
    
    # block replacements
    self.cms_blocks.each do |block|
      page_content.gsub!(/\{\{\s*cms_block:#{block.label}:.*?s*\}\}/, block.content)
    end
    
    # snippet replacements
    CmsSnippet.all.each do |snippet|
      page_content.gsub!(/\{\{\s*cms_snippet:#{snippet.label}\s*\}\}/, snippet.content)
    end
    
    page_content
  end
  
  def blocks=(blocks)
    blocks.each do |label, params|
      self.cms_blocks.build({:label => label}.merge(params))
    end
  end
  
  def ancestors_for_select
    CmsPage.all.collect{|p| [p.label, p.id]}
  end
  
protected
  
  def assign_full_path
    self.full_path = (self.ancestors.reverse.collect{|p| p.slug} + [self.slug]).join('/')
  end
  
end
