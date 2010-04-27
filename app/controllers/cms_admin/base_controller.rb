class CmsAdmin::BaseController < ActionController::Base
  
  before_filter :authenticate
  
  layout 'cms_admin'
  
  def save_tree_state(object)
    name = object.class.name.underscore.to_sym
    session[name] ||= []
    if session[name].include?(object.id)
      session[name].reject!{|v| v==object.id}
    else
      session[name] << object.id
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