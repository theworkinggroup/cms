class CmsContentController < ApplicationController
  
  def show
    
    if (@page = CmsPage.find_by_full_path(params[:path].join('/')))
      render :inline => @page.content
    else
      render :text => '404', :status => 404
    end
    
  end
  
end
