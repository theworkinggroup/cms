ActionController::Routing::Routes.draw do |map|
  
  map.namespace :cms_admin do |cms_admin|
    cms_admin.resources :layouts
    cms_admin.resources :pages
    cms_admin.resources :snippets
  end
  
  map.connect '/*path', :controller => 'cms_content', :action => 'show'
  
end
