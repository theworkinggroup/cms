class CmsFormBuilder < ActionView::Helpers::FormBuilder
  
  %w{ date_select text_field password_field text_area file_field}.each do |selector|
    src = <<-end_src
      def #{selector}(method, options = {})
        options.merge!(:size=> '') if #{%w{text_field password_field}.include?(selector)}
        standard_field('#{selector}', method, options) { super(method, options) } 
      end
    end_src
    class_eval src, __FILE__, __LINE__
  end
  
  def standard_field(type, method, options={}, &block)
    description = options.delete(:desc)
    content = options.delete(:content)
    label = label_for(method, options)
    required = options.delete(:required)
    
    output = "<div class='form_element #{type}_element'>"
      if type != 'check_box'
        output << "<div class='label'>#{label}"
        output << "#{@template.content_tag(:span, '*', :class => 'required_ind') if required }"
        output << "</div>"
      end
      output << "<div class='value'>"
        output << "#{yield}#{content}"
        output << "#{error_messages_for(method)}"
        output << "#{description(description)}" if type != 'check_box'
      output << "</div>"
    output << "</div>"

    output
  end
  
  def custom_element(label, content, options={})
    css_class = options[:css_class].blank? ? "text_field_element" : options[:css_class]
    errors = if options[:method_name]
      error_for(options.delete(:method_name))
    elsif options[:method_names]
      method_names = options.delete(:method_names)
      method_names.collect{|method_name| error_for(method_name)}.uniq.join(' ')
    end
    %{
      <div class='form_element #{css_class}'>
        <div class='label'>
          #{label}
        </div>
        <div class='value'>
          #{content}
          #{errors}
          #{description(options.delete(:desc))}
        </div>
      </div>
    }
  end
  
  def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
    options[:content] = label_for(method, options)
    options[:label] = '&nbsp;'
    standard_field('check_box', method, options) { super(method, options, checked_value, unchecked_value) }     
  end
  
  def radio_button(method, tag_value, options = {})
    if options && options[:choices]
      radios = options[:choices].collect{|choice| super(method, choice[0]) + %{<label for="#{object_name}_#{method}_#{choice[0]}">#{choice[1]}</label><div class="clearfloat"></div>}}.join
      standard_field('radio_button', method, options) { radios }
    else
      standard_field('radio_button', method, options) { super(method, tag_value, options = {}) }      
    end
  end
  
  def select(method, choices, options = {}, html_options = {})
    standard_field('select', method, options) { super(method, choices, options, html_options) } 
  end
    
  def hidden_field(method, options = {}, html_options = {})
    super(method, options)
  end
  
  def submit(value, options={}, &block)
    cancel_link = @template.capture(&block) if block_given?
    cancel_link ||= options[:cancel_url] ? ' or ' + options[:cancel_url] : ''
    if options[:show_activity_indicator]
      options[:onclick] = "$(this).parent().next().show(); $(this).parent().hide();"
    end
    submit_id = Time.now.usec
    out = @template.content_tag(:div,
      %{
        #{super(value, options.merge(:style=>'visibility:hidden;position: absolute', :id => submit_id))}
        <a class="button" href="#" id="#{submit_id}_link" onclick="$('##{submit_id}').trigger('click');return false;">#{value}</a>
        #{cancel_link}
      }, :class => 'form_element submit_element')
    if options[:show_activity_indicator]
      out << %{
        <div class="form_element submit_element" style="display:none">
          <div class="activity_indicator">
            <img src="/images/cms/ajax_loader.gif" />
            #{options[:show_activity_indicator]}
          </div>
        </div>
      } 
    end
    out
  end
  
  def label_for(method, options)
    label = options.delete(:label) || method.to_s.titleize.capitalize
    "<label for=\"#{object_name}_#{method}\">#{label}</label>"
  end  
  
  def description(description)
    "<div class='description'>#{description}</div>" unless description.nil?
  end
  
  def error_messages
    if @object && !@object.errors.empty?
      message = @object.errors[:base] ? @object.errors[:base]: 'There were some problems submitting this form. <br/>Please correct all the highlighted fields and try again'
      @template.content_tag(:div, message, :class => 'errorExplanation') 
    end
  end
  
  def error_messages_for(method)
    if (!@object.nil? and @object.respond_to?(:errors) and errors = @object.errors.on(method))
      "<div class=\'errors\'>#{method.to_s.humanize} #{errors.is_a?(Array) ? errors.first : errors}</div>"
    else
      ''
    end
  end
end
