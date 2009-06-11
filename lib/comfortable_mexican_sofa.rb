require 'comfortable_mexican_sofa/cms_rails_extensions'
require 'comfortable_mexican_sofa/acts_as_tree'

# loading engine routes
class ActionController::Routing::RouteSet
  def load_routes_with_cms!
    cms_routes = File.join(File.dirname(__FILE__), *%w[.. config cms_routes.rb])
    add_configuration_file(cms_routes) unless configuration_files.include? cms_routes
    load_routes_without_cms!
  end
 
  alias_method_chain :load_routes!, :cms
end