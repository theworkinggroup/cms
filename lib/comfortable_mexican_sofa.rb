require 'comfortable_mexican_sofa/cms_rails_extensions'
require 'comfortable_mexican_sofa/cms_acts_as_tree'
require 'comfortable_mexican_sofa/cms_tag'

unless defined?(ActiveLinkHelper)
  require File.join(File.dirname(__FILE__), "..", "vendor", "active_link_helper", "init") 
end

unless defined?(Paperclip)
  require File.join(File.dirname(__FILE__), "..", "vendor", "paperclip", "init")
end

# Helper inclusion
ActionView::Base.send(:include, CmsHelper)

module ComfortableMexicanSofa
  class Config
    def self.cattr_accessor_with_default(name, value = nil)
      cattr_accessor name
      self.send("#{name}=", value) if value
    end
    
    cattr_accessor_with_default :http_auth_enabled,   true
    cattr_accessor_with_default :http_auth_username,  'username'
    cattr_accessor_with_default :http_auth_password,  'password'
    cattr_accessor_with_default :cms_title
    cattr_accessor_with_default :additional_cms_tabs, {}
  end
  
  def self.config(&block)
    yield ComfortableMexicanSofa::Config
  end
end

# loading engine routes
class ActionController::Routing::RouteSet
  def load_routes_with_cms!
    cms_routes = File.join(File.dirname(__FILE__), *%w[.. config cms_routes.rb])
    add_configuration_file(cms_routes) unless configuration_files.include? cms_routes
    load_routes_without_cms!
  end
  
  alias_method_chain :load_routes!, :cms
end