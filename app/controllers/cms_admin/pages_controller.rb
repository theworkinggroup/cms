class CmsAdmin::PagesController < CmsAdmin::BaseController
  
  def index
    @pages = CmsPage.roots
  end
  
  def new
    @page = CmsPage.new(params.slice(:parent_id))
  end
  
  def create
    
    @page = CmsPage.new(params[:page])
    @page.save!
    
    # raise @page.to_yaml
  end
  
end
