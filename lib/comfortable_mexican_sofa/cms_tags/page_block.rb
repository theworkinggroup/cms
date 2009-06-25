class CmsTag::PageBlock < CmsTag::Tag
  
  FORMAT = {
    :text   => {
      :db_column    => :content_text,
      :description  => '',
      :form_output  => lambda { |tag|
        tag.view.text_area_tag "page[blocks][#{tag.label}][content_text]", tag.content, 
          :rows => 20
      }
    },
    :rich_text => {
      :db_column    => :content_text,
      :description  => '',
      :form_output  => lambda { |tag| 
        tag.view.text_area_tag "page[blocks][#{tag.label}][content_text]", tag.content,
          :rows   => 20, 
          :class  => 'mceEditor'
      }
    },
    :code => {
      :db_column    => :content_text,
      :description  => '',
      :form_output  => lambda { |tag| 
        tag.view.content_tag :div, :class => 'codemirror' do 
          tag.view.text_area_tag "page[blocks][#{tag.label}][content_text]", tag.content,
            :rows   => 20, 
            :class  => 'codeTextArea'
        end
      }
    },
    :string => {
      :db_column    => :content_string,
      :description  => '',
      :form_output  => lambda { |tag| 
        tag.view.text_field_tag "page[blocks][#{tag.label}][content_string]", tag.content
      }
    },
    :integer => {
      :db_column    => :content_integer,
      :description  => '',
      :form_output  => lambda { |tag| 
        tag.view.text_field_tag "page[blocks][#{tag.label}][content_integer]", tag.content
      }
    },
    :boolean => {
      :db_column    => :content_boolean,
      :description  => '',
      :form_output  => lambda { |tag| 
        tag.view.check_box_tag "page[blocks][#{tag.label}][content_boolean]", tag.content
      }
    },
    :date => {
      :db_column   => :content_datetime,
      :description => '',
      :form_output => lambda { |tag| 
        tag.view.date_select "page[blocks][#{tag.label}][content_datetime]", tag.content
      }
    },
    :time => {
      :db_column   => :content_datetime,
      :description => '',
      :form_output => lambda { |tag| 
        tag.view.date_select "page[blocks][#{tag.label}][content_datetime]", tag.content
      }
    }
  }
  
  attr_accessor :format
  
  def self.regex
    /\{\{\s*?cms_page_block:(.*?)\s*?\}\}/
  end
  
  # this shold be the most important tag to render, but let's leave space
  # for some unforseen cases
  def self.render_priority
    1 
  end
  
  def self.has_form?
    true
  end
  
  def assign_accessors
    tokens = self.tag_signature.split(':')
    self.label = tokens[0]
    self.format = tokens[1]
  end
  
  def regex
    /\{\{\s*?cms_page_block:#{label}.*?\s*?\}\}/
  end
  
  def form_label
    view.label_tag label.titleize
  end
  
  def form_input
    if FORMAT.has_key? self.format.to_sym
      FORMAT[self.format.to_sym][:form_output].call(self)
    else
      'Unknown tag format'
    end
  end
  
  def content
    page.try("cms_block_#{self.label}").try(FORMAT[self.format.to_sym][:db_column]) rescue ''
  end
  
  def render
    content.to_s
  end
  
end