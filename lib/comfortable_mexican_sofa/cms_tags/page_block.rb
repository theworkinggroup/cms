class CmsTag::PageBlock < CmsTag::Tag
  
  def self.regex
    /\{\{\s*?cms_page_block:(.*?)\s*?\}\}/
  end
  
  # this shold be the most important tag to render, but let's leave space
  # for some unforseen cases
  def self.render_priority
    1 
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
    when 'rich_text'
      view.text_area_tag "page[blocks][#{label}][content]", content, :rows => 20, :class => 'mceEditor'
    else
      'Unknown tag format'
    end
  end
  
  def content
    page.try("cms_block_#{self.label}").try(:content) rescue ''
  end
  
  def render
    content
  end
  
  
end