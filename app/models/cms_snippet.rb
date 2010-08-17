class CmsSnippet < ActiveRecord::Base

  # -- Validations ----------------------------------------------------------
  validates_presence_of   :label
  validates_uniqueness_of :label
  validates_format_of     :label,
    :with   => /^\w[a-z0-9_-]*$/i

  # -- Class Methods --------------------------------------------------------
  def self.content_for(label)
    s = find_by_label(label)
    s.blank? ? '' : s.content.html_safe
  end

end
