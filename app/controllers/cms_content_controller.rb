class CmsContentController < ApplicationController
  
  include CmsCommon::RenderPage
  
  unloadable
  
  before_filter :parse_path, :only => :show
  
  def show
    @cms_page = CmsPage.published.find_by_full_path(params[:path].join('/'))
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
