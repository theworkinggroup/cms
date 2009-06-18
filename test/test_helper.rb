ENV["RAILS_ENV"] = "test"

require File.expand_path(File.dirname(__FILE__) + "/rails_root/config/environment")
require 'test_help'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  
  fixtures :all
  
  def http_auth
    @request.env['HTTP_AUTHORIZATION'] = "Basic #{Base64.encode64('username:password')}"
  end
  
  
end