class CmsAdmin::PagesController < CmsAdmin::BaseController
  
  include CmsCommon::RenderPage
  
  before_filter :load_page, :only => [:children, :edit, :update, :destroy, :reorder]
  
  def index
    params[:root] ? @cms_pages = CmsPage.find(params[:root]).children : @cms_pages = CmsPage.roots
  end
  
  def children
    manage_session_array(:cms_page_tree, (params[:state] == 'open' ? :remove : :add), params[:id])
  end
  
  def new
    @cms_page = CmsPage.new(params.slice(:parent_id))
    @cms_page.published_at = Time.now.utc
    @cms_page.cms_layout = @cms_page.parent.cms_layout if @cms_page.parent
  end
  
  def edit
    # ...
  end
  
  def create
    @cms_page = CmsPage.new(params[:cms_page])
    
    return render_page if !params[:preview].blank? && @cms_page.valid?
    
    @cms_page.save!
    
    flash[:notice] = 'Page created'
    manage_session_array(:cms_page_tree, :add, @cms_page.parent_id.to_s)
    redirect_to :action => :edit, :id => @cms_page
    
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end
  
  def update
    @cms_page.attributes = params[:cms_page]
    
    return render_page if !params[:preview].blank? && @cms_page.valid?
    
    @cms_page.save!
    
    flash[:notice] = 'Page updated'
    redirect_to :action => :edit, :id => @cms_page
    
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end
  
  def destroy
    @cms_page.destroy
    
    flash[:notice] = 'Page removed'
    redirect_to :action => :index
  end
  
  def form_blocks
    @cms_page = CmsPage.find_by_id(params[:id])
    @layout = CmsLayout.find(params[:layout_id])
  end
  
  def reorder
    params["page_#{@cms_page.id}_branch"].each_with_index do |id, position|
      @cms_page.children.find(id).update_attribute(:position, position)
    end
    render :nothing => true
  end
  
protected

  def load_page
    @cms_page = CmsPage.find_by_id(params[:id])
  end
  
end
