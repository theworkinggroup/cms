class CmsAdmin::BaseController < ApplicationController
  
  before_filter :authenticate
  
  layout 'cms_admin'
  
  def manage_session_array(name, action, value)
    session[name] = case action
    when :add
      (session[name] || []) + [value]
    when :remove
      (session[name] || []) - [value]
    end
  end
  
protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ComfortableMexicanSofa::Config.http_auth_username && 
      password == ComfortableMexicanSofa::Config.http_auth_password
    end if ComfortableMexicanSofa::Config.http_auth_enabled
  end
  
end