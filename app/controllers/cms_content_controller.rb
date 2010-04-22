class CmsContentController < ApplicationController
  include CmsCommon::RenderPage
  
  unloadable
  
  before_filter :assign_cms_root
  before_filter :parse_path, :only => :show
  
  def show
    @cms_page_slug = params[:path].join('/')
    @cms_page = (@cms_site ? @cms_site.cms_pages : CmsPage).find_by_full_path(@cms_page_slug)

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
    if (ComfortableMexicanSofa::Config.multiple_sites)
      @cms_site = CmsSite.find_by_hostname(request.host.downcase)
    end
  end

  def parse_path
    params[:format] = (params[:path].last && params[:path].last.match(/\.(.*?)$/) && $1) || 'html'
    params[:path].last and params[:path].last.gsub!(/\.(.*?)$/, '')
  end
end
