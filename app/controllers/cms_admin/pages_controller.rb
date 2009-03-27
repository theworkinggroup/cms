class CmsAdmin::PagesController < CmsAdmin::BaseController
  
  before_filter :load_page, :only => [:children, :edit, :update, :destroy]
  
  def index
    @pages = CmsPage.roots
  end
  
  def children
    manage_session_array(:cms_page_tree, (params[:state] == 'open' ? :remove : :add), params[:id])
  end
  
  def new
    @page = CmsPage.new(params.slice(:parent_id))
  end
  
  def create
    @page = CmsPage.new(params[:page])
    @page.save!
    
    flash[:notice] = 'Page created'
    manage_session_array(:cms_page_tree, :add, @page.parent_id.to_s)
    redirect_to :action => :index
    
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end
  
  def destroy
    @page.destroy
    
    flash[:notice] = 'Page removed'
    redirect_to :action => :index
  end
  
protected

  def load_page
    @page = CmsPage.find(params[:id])
  end
  
end
