require File.dirname(__FILE__) + '/../test_helper'

class RouteOrderTest < ActionDispatch::IntegrationTest
  
  def test_non_existant_contest
    # Ensure that application routes have higher priority than cms ones
    # This relies on the following route being in the rails_root test app
    #  match '/test_route' => redirect("/")
    get '/test_route'
    assert_response :redirect
    assert_redirected_to '/route_order_correct'
  end

end
