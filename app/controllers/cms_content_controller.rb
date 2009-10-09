class CmsContentController < ApplicationController
  
  include CmsCommon::RenderPage
  
  unloadable
  
  before_filter :parse_path, :only => :show
  
  def show
    @cms_page_slug = params[:path].join('/')
    @cms_page = CmsPage.published.find_by_full_path(@cms_page_slug)
    render_page
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
