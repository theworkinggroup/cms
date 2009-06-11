ActionController::Routing::Routes.draw do |map|
  
  map.namespace :cms_admin do |cms_admin|
    cms_admin.connect '/', :controller => 'pages', :action => 'index'
    cms_admin.resources :layouts,
      :member => {  :children     => :any,
                    :reorder      => :any }
    cms_admin.resources :pages,
      :member => {  :children     => :any,
                    :form_blocks  => :any,
                    :reorder      => :any }
    cms_admin.resources :snippets,
      :collection => { :reorder   => :any }
  end
  
  map.connect '*path', :controller => 'cms_content', :action => 'show'
  
end
