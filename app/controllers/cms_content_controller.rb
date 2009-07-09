class CmsContentController < ApplicationController
  
  unloadable
  
  before_filter :parse_path, :only => :show
  
  def show
    @cms_page = CmsPage.find_by_full_path(params[:path].join('/'))
    
    # Rendering 404 page
    if !@cms_page
      @cms_page = CmsPage.find_by_full_path('404')
      if !@cms_page
        render :text => '404 Page Not Found', :status => 404
      else
        render :inline => @cms_page.content, :layout => (@cms_page.cms_layout.app_layout || false), :status => 404
      end
      return
    end
    
    respond_to do |format|
      format.html do
        @cms_page = @cms_page.redirect_to_page if @cms_page.redirect_to_page
        render :inline => @cms_page.content, :layout => (@cms_page.cms_layout.app_layout || false)
      end
      format.xml do
        @cms_page_children = @cms_page.children[0...25].collect do |p|
          p.rendered_content = render_to_string(:inline => p.content, :layout => false)
          p
        end
      end
    end
  end
  
  def sitemap
    respond_to do |format|
      format.xml do
        @cms_pages = CmsPage.all
      end
    end
  end
  
protected

  def parse_path
    params[:format] = (params[:path].last && (match = params[:path].last.match(/\.(.*?)$/)) && match[1]) || 'html'
    params[:path].last && params[:path].last.gsub!(/\.(.*?)$/, '')
  end
  
end
