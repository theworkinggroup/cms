class CmsContentController < ApplicationController
  include CmsCommon::RenderPage
  
  unloadable
  
  before_filter :assign_cms_root
  before_filter :parse_path, :only => :show
  
  def show
    @cms_page_slug = [ @cms_root_path, params[:path] ].flatten.compact.join('/')
    @cms_page = CmsPage.visible_scope.find_by_full_path(@cms_page_slug)

    render_page
  end
  
  def sitemap
    respond_to do |format|
      format.xml do
        @cms_pages = CmsPage.visible_scope
      end
    end
  end
  
protected
  def assign_cms_root
    @cms_root_path = [ request.host.slugify ]
  end

  def parse_path
    params[:format] = (params[:path].last && params[:path].last.match(/\.(.*?)$/) && $1) || 'html'
    params[:path].last and params[:path].last.gsub!(/\.(.*?)$/, '')
  end
end
