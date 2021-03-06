ActionController::Routing::Routes.draw do |map|
  map.namespace :cms_admin, :path_prefix => 'cms-admin' do |cms_admin|
    cms_admin.connect '/', :controller => 'base', :action => 'index'

    cms_admin.resources :layouts,
      :collection => { :reorder      => :put },
      :member => {  :children     => :any,
                    :toggle       => :any }
    cms_admin.resources :pages,
    :collection => { :reorder      => :put },
      :member => {  :toggle       => :any,
                    :form_blocks  => :any }
                    
    cms_admin.resources :snippets,
      :collection => { :reorder   => :any }
    cms_admin.resources :sites
    cms_admin.resources :categories,
      :member => { :children => :any, :toggle => :any }
  end
  
  map.with_options :controller => 'cms_content' do |cms|
    cms.connect '/sitemap.xml', :action => 'sitemap'
    cms.connect '*path', :action => 'show'
  end
end
