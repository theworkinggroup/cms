class CmsAdmin::BaseController < ApplicationController
  
  layout 'cms_admin'
  
  def manage_session_array(name, action, value)
    session[name] = case action
    when :add
      (session[name] || []) + [value]
    when :remove
      (session[name] || []) - [value]
    end
  end
  
end