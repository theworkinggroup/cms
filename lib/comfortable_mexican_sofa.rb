require 'comfortable_mexican_sofa/cms_rails_extensions'
require 'comfortable_mexican_sofa/acts_as_tree'

module ComfortableMexicanSofa
  class Config
    def self.cattr_accessor_with_default(name, value = nil)
      cattr_accessor name
      self.send("#{name}=", value) if value
    end
    
    cattr_accessor_with_default :http_auth_enabled,   true
    cattr_accessor_with_default :http_auth_username,  'username'
    cattr_accessor_with_default :http_auth_password,  'password'
    cattr_accessor_with_default :cms_title,           nil
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