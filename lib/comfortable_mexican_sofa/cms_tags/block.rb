class CmsTag::Block < CmsTag::Tag
  
  def self.regex
    /\{\{\s*?cms_block:(.*?)\s*?\}\}/
  end
  
  def self.render_priority
    2
  end
  
  def form_label
    view.label_tag label.titleize
  end
  
  def form_input
    case self.format
    when 'string'
      view.text_field_tag "page[blocks][#{label}][content]", content
    when 'text'
      view.text_area_tag "page[blocks][#{label}][content]", content, :rows => 20
    else
      'Unknown tag format'
    end
  end
  
  def content
    page.try("cms_block_#{self.label}").try(:content) || ''
  end
  
  def render
    ''
  end

end