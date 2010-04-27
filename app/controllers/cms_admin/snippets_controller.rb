class CmsAdmin::SnippetsController < CmsAdmin::BaseController
  
  before_filter :load_cms_snippet, :only => [:edit, :update, :destroy]
  before_filter :build_cms_snippet, :only => [:new, :create]
  
  def index
    @cms_snippets = CmsSnippet.all
  end
  
  def new
    # ...
  end
  
  def edit
    # ...
  end
  
  def create
    @cms_snippet.save!
    
    flash[:notice] = 'Snippet created'
    redirect_to edit_cms_admin_snippet_path(@cms_snippet)
    
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end
  
  def update
    @cms_snippet.update_attributes!(params[:cms_snippet])
    
    flash[:notice] = 'Snippet updated'
    redirect_to edit_cms_admin_snippet_path(@cms_snippet)
    
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end
  
  def destroy
    @cms_snippet.destroy
    
    flash[:notice] = 'Snippet removed'
    redirect_to cms_admin_snippets_path
  end
  
  def reorder
    params[:snippet_list].each_with_index do |id, position|
      CmsSnippet.find(id).update_attribute(:position, position)
    end
    render :nothing => true
  end
  
protected

  def load_cms_snippet
    @cms_snippet = CmsSnippet.find_by_id(params[:id])
  end
  
  def build_cms_snippet
    params[:cms_snippet] ||= { }
    @cms_snippet = CmsSnippet.new(params[:cms_snippet])
  end
  
end
