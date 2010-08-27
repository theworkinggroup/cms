require 'comfortable_mexican_sofa'
require 'rails'
require 'action_controller'

module ComfortableMexicanSofa
  class Engine < Rails::Engine
  end
end

ActiveSupport.on_load(:action_controller) do
  ActionController::Base.helper CmsHelper
end
