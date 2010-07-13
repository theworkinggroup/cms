RailsRoot::Application.routes.draw do |map|
  match '/test_route' => redirect("/route_order_correct")
end
