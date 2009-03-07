class CmsContentController < ApplicationController
  
  def show
    render :inline => CmsPage.first.content
  end
  
end
