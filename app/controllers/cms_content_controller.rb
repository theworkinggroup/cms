class CmsContentController < ApplicationController
  
  unloadable
  
  def show
    
    if (@page = CmsPage.find_by_full_path(params[:path].join('/')))
      @page = @page.redirect_to_page if @page.redirect_to_page
      
      render :inline => @page.content, :layout => (@page.cms_layout.app_layout || false)
    else
      render :text => '404', :status => 404
    end
    
  end
  
end
