class CmsAdmin::LayoutsController < CmsAdmin::BaseController
  
  before_filter :load_layout, :only => [:children, :edit, :update, :destroy]
  
  def index
    @layouts = CmsLayout.root
  end
  
  def children
    respond_to do |format|
      format.js
    end
  end
  
  def new
    # ...
  end
  
  def edit
    # ...
  end
  
  def create
    @layout = CmsLayout.new(params[:layout])
    @layout.save!
    
    flash[:notice] = 'Layout created'
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
  
protected

  def load_layout
    @layout = CmsLayout.find(params[:id])
  end
  
end
