class CmsAdmin::LayoutsController < CmsAdmin::BaseController
  
  before_filter :load_layout, :only => [:children, :edit, :update, :destroy, :form_blocks]
  
  def index
    @layouts = CmsLayout.roots
  end
  
  def children
    manage_session_array(:cms_layout_tree, (params[:state] == 'open' ? :remove : :add), params[:id])
  end
  
  def new
    @layout = CmsLayout.new(params.slice(:parent_id))
  end
  
  def edit
    # ...
  end
  
  def create
    @layout = CmsLayout.new(params[:layout])
    @layout.save!
    
    flash[:notice] = 'Layout created'
    manage_session_array(:cms_layout_tree, :add, @layout.parent_id.to_s)
    redirect_to :action => :index
    
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end
  
  def update
    @layout.update_attributes!(params[:layout])
    
    flash[:notice] = 'Layout updated'
    redirect_to :action => :index
    
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end
  
  def destroy
    @layout.destroy
    
    flash[:notice] = 'Layout removed'
    redirect_to :action => :index
  end
  
  def form_blocks
    # ...
  end
  
protected

  def load_layout
    @layout = CmsLayout.find(params[:id])
  end
  
end
