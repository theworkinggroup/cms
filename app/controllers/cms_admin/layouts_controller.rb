class CmsAdmin::LayoutsController < CmsAdmin::BaseController
  
  before_filter :load_layout, :only => [:children, :edit, :update, :destroy, :reorder]
  
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
    redirect_to :action => :edit, :id => @layout
    
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end
  
  def update
    @layout.update_attributes!(params[:layout])
    
    flash[:notice] = 'Layout updated'
    redirect_to :action => :edit, :id => @layout
    
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end
  
  def destroy
    @layout.destroy
    
    flash[:notice] = 'Layout removed'
    redirect_to :action => :index
  end
  
  def reorder
    if @layout
      layout_id = @layout.id
      find_scope = @layout.children
    else
      layout_id = 0
      find_scope = CmsLayout
    end
    
    params["layout_#{layout_id}_branch"].each_with_index do |id, position|
      find_scope.find(id).update_attribute(:position, position)
    end
    render :nothing => true
  end
  
protected

  def load_layout
    @layout = CmsLayout.find_by_id(params[:id])
  end
  
end
