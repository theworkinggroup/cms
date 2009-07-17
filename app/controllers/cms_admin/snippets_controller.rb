class CmsAdmin::SnippetsController < CmsAdmin::BaseController
  
  before_filter :load_snippet, :only => [:edit, :update, :destroy]
  
  def index
    @snippets = CmsSnippet.paginate :page => params[:page]
  end
  
  def new
    # ...
  end
  
  def edit
    # ...
  end
  
  def create
    @snippet = CmsSnippet.new(params[:snippet])
    @snippet.save!
    
    flash[:notice] = 'Snippet created'
    redirect_to :action => :edit, :id => @snippet
    
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end
  
  def update
    @snippet.update_attributes!(params[:snippet])
    
    flash[:notice] = 'Snippet updated'
    redirect_to :action => :edit, :id => @snippet
    
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end
  
  def destroy
    @snippet.destroy
    
    flash[:notice] = 'Snippet removed'
    redirect_to :action => :index
  end
  
  def reorder
    params[:snippet_list].each_with_index do |id, position|
      CmsSnippet.find(id).update_attribute(:position, position)
    end
    render :nothing => true
  end
  
protected

  def load_snippet
    @snippet = CmsSnippet.find_by_id(params[:id])
  end
  
end
