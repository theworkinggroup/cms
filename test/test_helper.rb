ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/rails_root/config/environment")
require 'test_help'

Fixtures.create_fixtures( File.expand_path( File.dirname(__FILE__) + "/fixtures" ), ActiveRecord::Base.connection.tables ) 

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  fixtures :all
end