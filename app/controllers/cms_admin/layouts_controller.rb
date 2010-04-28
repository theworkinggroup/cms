class CmsAdmin::LayoutsController < CmsAdmin::BaseController
  before_filter :load_layout, :only => [ :children, :edit, :update, :destroy, :reorder ]
  
  def index
    @cms_layouts = CmsLayout.roots
  end
  
  def children
    manage_session_array(:cms_layout_tree, (params[:state] == 'open' ? :remove : :add), params[:id])
  end
  
  def new
    @cms_layout = CmsLayout.new(params.slice(:parent_id))
  end
  
  def edit
    # ...
  end
  
  def create
    @cms_layout = CmsLayout.new(params[:cms_layout])
    @cms_layout.save!
    
    flash[:notice] = 'Layout created'
    manage_session_array(:cms_layout_tree, :add, @cms_layout.parent_id.to_s)
    redirect_to edit_cms_admin_layout_path(@cms_layout)
    
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end
  
  def update
    @cms_layout.update_attributes!(params[:cms_layout])
    
    flash[:notice] = 'Layout updated'
    redirect_to edit_cms_admin_layout_path(@cms_layout)
    
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end
  
  def destroy
    @cms_layout.destroy
    
    flash[:notice] = 'Layout removed'
    redirect_to cms_admin_layouts_path
  end
  
  def reorder
    if @cms_layout
      layout_id = @cms_layout.id
      find_scope = @cms_layout.children
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
    @cms_layout = CmsLayout.find_by_id(params[:id])
  end
end
