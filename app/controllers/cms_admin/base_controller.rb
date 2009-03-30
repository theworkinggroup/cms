class CmsAdmin::BaseController < ApplicationController
  
  helper_method :application_name
  
  layout 'cms_admin'
  
  def manage_session_array(name, action, value)
    session[name] = case action
    when :add
      (session[name] || []) + [value]
    when :remove
      (session[name] || []) - [value]
    end
  end
  
  def application_name
    c = %w( crazy cool colorful cremated creamed crusty clapping campy crude corky comfortable crappy )
    m = %w( massive monster mini mighty morbid mexican moses machine mucus murder )
    s = %w( ship shark scarf scott slayer slave shovel school stool swan squid smoke sloth sofa sean )
    [c, m, s].collect{|a| a.sort_by{rand}.first.capitalize}.join
  end
  
end