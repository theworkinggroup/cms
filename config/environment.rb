RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  
  config.gem 'haml'
  config.gem 'theworkinggroup-active_link_helper', :lib => 'active_link_helper'
  
  config.time_zone = 'UTC'

end