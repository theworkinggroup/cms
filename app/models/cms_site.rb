class CmsSite < ActiveRecord::Base
  # -- Relationships --------------------------------------------------------

  belongs_to :cms_page

  has_many :hostnames,
    :class_name => 'CmsSiteHostname',
    :dependent => :destroy

  accepts_nested_attributes_for :hostnames,
    :allow_destroy => true,
    :reject_if => proc { |attributes| attributes['hostname'].blank? }
  
  # -- Validations ----------------------------------------------------------

  validates_presence_of :label
  validates_uniqueness_of :label
  
  # -- Scopes ---------------------------------------------------------------

  default_scope :order => 'label ASC'
  
  # -- Callbacks ------------------------------------------------------------
  
  before_save :create_page
  after_save :backlink_page
  
  # -- Class Methods --------------------------------------------------------

  def self.options_for_select
    [ [ '---', nil ] ] + CmsSite.all.collect { |l| [ l.label, l.id ] }
  end
  
  # -- Instance Methods -----------------------------------------------------
  
protected
  def create_page
    self.cms_page ||= CmsPage.create(
      :label => self.label,
      :cms_site => self
    )
  end
  
  def backlink_page
    if (self.cms_page.cms_site_id != self.id)
      self.cms_page.cms_site_id = self.id
      self.cms_page.save(false)
    end
  end
end
