class CmsAdmin::PagesController < CmsAdmin::BaseController
  
  before_filter :load_page, :only => [:children, :edit, :update, :destroy, :reorder]
  
  def index
    @pages = CmsPage.roots
  end
  
  def children
    manage_session_array(:cms_page_tree, (params[:state] == 'open' ? :remove : :add), params[:id])
  end
  
  def new
    @page = CmsPage.new(params.slice(:parent_id))
    @page.cms_layout = @page.parent.cms_layout if @page.parent
  end
  
  def edit
    # ...
  end
  
  def create
    @page = CmsPage.new(params[:page])
    @page.save!
    
    flash[:notice] = 'Page created'
    manage_session_array(:cms_page_tree, :add, @page.parent_id.to_s)
    redirect_to :action => :index
    
  rescue ActiveRecord::RecordInvalid => e
    @page = e.record
    render :action => :new
  end
  
  def update
    @page.update_attributes!(params[:page])
    
    flash[:notice] = 'Page updated'
    redirect_to :action => :index
    
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end
  
  def destroy
    @page.destroy
    
    flash[:notice] = 'Page removed'
    redirect_to :action => :index
  end
  
  def form_blocks
    @page = CmsPage.find_by_id(params[:id])
    @layout = CmsLayout.find(params[:layout_id])
  end
  
  def reorder
    params["page_#{@page.id}_branch"].each_with_index do |id, position|
      @page.children.find(id).update_attribute(:position, position)
    end
    render :nothing => true
  end
  
protected

  def load_page
    @page = CmsPage.find_by_id(params[:id])
  end
  
end
