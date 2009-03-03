ActionController::Routing::Routes.draw do |map|
  
  map.connect '/*path', :controller => 'content', :action => 'show'
  
end
