class CmsContentController < ApplicationController
  
  unloadable
  
  def show
    if (@cms_page = CmsPage.find_by_full_path(params[:path].join('/')))
      @cms_page = @cms_page.redirect_to_page if @cms_page.redirect_to_page
      
      render :inline => @cms_page.content, :layout => (@cms_page.cms_layout.app_layout || false)
    else
      render :text => '404', :status => 404
    end
    
  end
  
end
