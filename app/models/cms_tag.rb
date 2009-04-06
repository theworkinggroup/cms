module CmsTag
  class Tag
    attr_accessor :type,
                  :label,
                  :datatype
    
    def initialize(tag = nil)
      self.type, self.label, self.datatype = tag.split(':') if tag
    end
    
    def ==(tag)
      self.type == tag.type && self.label == tag.label
    end
    
    def to_s
      "#{type}:#{label}:#{datatype}"
    end
    
  end
  
  module InstanceMethods
    def tags(content = self.content)
      content.scan(/\{\{\s*(.*?)\s*\}\}/).flatten.collect{|t| CmsTag::Tag.new(t)}
    end
  end
end