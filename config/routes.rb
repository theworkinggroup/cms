ActionController::Routing::Routes.draw do |map|
  
  map.namespace :cms_admin do |cms_admin|
    cms_admin.resources :layouts,
      :member => {  :children     => :any },
      :collection => { :form_blocks => :any }
    cms_admin.resources :pages,
      :member => { :children => :any }
    cms_admin.resources :snippets
  end
  
  map.connect '/*path', :controller => 'cms_content', :action => 'show'
  
end
