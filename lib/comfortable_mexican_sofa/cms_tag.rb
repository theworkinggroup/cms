module CmsTag
  
  class TagError < StandardError; end
  
  # Methods to this module are accessed indirectly from including it
  #   include CmsTag::Tags
  # CmsLayout in our case will be able to fetch its tags like this:
  #  @cms_layout.tags
  module Tags
    
    # initializes all tags found in the provided content
    def tags(*args)
      options = args.extract_options!
      content = args.first || self.content
      raise TagError, 'No content provided' if content.blank?
      
      tags = []
      CmsTag::Tag.subclasses.each do |tag|
        tag = tag.constantize
        tags << tag.parse_tags(content).collect{|tag_string| tag.new(tag_string, options)}
      end
      tags.flatten
    end
  end
  
  class Tag
    attr_accessor :label, :format, :view, :page
    
    # Returns tag type based on it's classname
    #   CmsTag::MyAwesomeTag.type => 'cms_my_awesome_tag'
    def self.type
      'cms_' + to_s.split('::').last.underscore
    end
    
    # regular expression that finds tag signature
    def self.regex
      //
    end
    
    # Returns tag identifiers from passed content based on regex defined
    # for the particular tag
    def self.parse_tags(content)
      content.scan(regex).flatten
    end
    
    def initialize(*args)
      options = args.extract_options!
      tag_signature = args.first
      
      tokens = tag_signature.split(':')
      self.label = tokens[0]
      self.format = tokens[1]
      
      # provides access to action view methods for rendering form elements
      if options[:view]
        unless options[:view].is_a?(ActionView::Base)
          raise TagError, "Expected ActionView::Base but got #{options[:view].class}" 
        end
        self.view = options[:view]
      end
      
      # owner of the the tag
      if options[:page]
        unless options[:page].is_a?(CmsPage)
          raise TagError, "Expected CmsPage but got #{options[:page].class}"
        end
        self.page = options[:page]
      end
    end
    
    def form_label
      "Label Undefined!"
    end
    
    def form_input
      "Form Field Undefined!"
    end
    
    def to_s
      'Undefined Tag'
    end
  end
  
end