require 'comfortable_mexican_sofa'
require 'rails'

module ComfortableMexicanSofa
  class Engine < Rails::Engine
    ActiveSupport::Dependencies.load_paths << File.dirname(__FILE__) + "/../../app/helpers"
    ActiveSupport::Dependencies.load_once_paths.delete File.dirname(__FILE__) + "/../../app/helpers"
    ActionController::Base.helper CmsHelper
  end
end
