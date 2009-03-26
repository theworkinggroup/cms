class CmsAdmin::PagesController < CmsAdmin::BaseController
  
  def index
    @pages = CmsPage.root
  end
  
  def new
    @page = CmsPage.new(params.slice(:parent_id))
  end
  
end
