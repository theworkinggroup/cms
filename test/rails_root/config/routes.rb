RailsRoot::Application.routes.draw do
  match '/test_route' => redirect("/route_order_correct")
end
