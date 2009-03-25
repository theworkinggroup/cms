class CmsLayout < ActiveRecord::Base
  
  # -- Relationships --------------------------------------------------------
  
  acts_as_tree :counter_cache => :children_count
  has_many :cms_pages, :dependent => :nullify
  
  
  # -- Validations ----------------------------------------------------------
  
  validates_presence_of :label
  validates_uniqueness_of :label
  validate  :validate_block_presence,
            :validate_block_uniqueness,
            :validate_proper_relationship
  
  
  # -- AR Callbacks ---------------------------------------------------------
  
  before_save :flag_as_extendable
  
  
  # -- Scopes ---------------------------------------------------------------
  
  named_scope :extendable, :conditions => { :is_extendable => true }
  
  
  # -- Class Methods --------------------------------------------------------
  
  def extendable_for_select
    [['---', nil]] + CmsLayout.extendable.all.reject{|l| ([self]+self.descendants).member?(l)}.collect{ |l| [l.label, l.id] }
  end
  
  
  # -- Instance Methods -----------------------------------------------------
  
  def content
    if parent
      parent.content.gsub(/\{\{\s*cms_block:default:.*?\}\}/, self.read_attribute(:content))
    else
      self.read_attribute(:content)
    end
  end
  
  def blocks
    self.content.scan(/\{\{\s*cms_block:(.*?)\s*\}\}/).flatten
  end
  
protected

  def validate_block_presence
    self.errors.add(:content, 'does not have any cms_blocks defined') if self.blocks.empty?
  end
  
  def validate_block_uniqueness
    self.errors.add(:content, 'has mutilple identical cms_blocks') if self.blocks.size != self.blocks.uniq.size
  end
  
  def validate_proper_relationship
    if self.descendants.member?(parent) || self.parent == self
      self.errors.add(:parent_id, 'layout is invalid') 
    end
  end
  
  def flag_as_extendable
    self.is_extendable = !self.content.scan(/\{\{\s*cms_block:default:.*?\}\}/).empty?
    true
  end

end
