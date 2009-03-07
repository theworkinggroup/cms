ActionController::Routing::Routes.draw do |map|
  
  map.connect '/*path', :controller => 'cms_content', :action => 'show'
  
end
