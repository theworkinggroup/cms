ActionController::Routing::Routes.draw do |map|
  
  map.namespace :cms_admin, :path_prefix => 'cms-admin' do |cms_admin|
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
    cms_admin.resources :attachments
    cms_admin.resources :categories,
      :member => {  :children => :any }
    cms_admin.resources :sections, :only => [ :show ]
  end
  
  map.with_options :controller => 'cms_content' do |cms|
    cms.connect '/sitemap.xml', :action => 'sitemap'
    cms.connect '*path', :action => 'show'
  end
  
end
