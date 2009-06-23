class CmsTag::Snippet < CmsTag::Tag
  
  def self.regex
    /\{\{\s*?cms_snippet:(.*?)\s*?\}\}/
  end
  
  def self.render_priority
    2
  end
  
  def render
    CmsSnippet.content_for(label)
  end
  
end