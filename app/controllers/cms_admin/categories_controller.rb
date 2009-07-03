class CmsAdmin::CategoriesController < CmsAdmin::BaseController
  before_filter :load_category, :except => [:create, :new, :index]
  
  def index
    @categories = CmsCategory.roots
  end
  
  def children
    manage_session_array(:category_tree, (params[:state] == 'open' ? :remove : :add), params[:id])
  end
  
  def new
    @category = CmsCategory.new(params.slice(:parent_id))
  end
  
  def create
    @category = CmsCategory.create!(params[:category])
    flash[:notice] = 'Category created'
    respond_to do |format|
      format.html { redirect_to cms_admin_categories_path }
      format.js
    end
  rescue ActiveRecord::RecordInvalid => e
    @category = e.record
    respond_to do |format|
      format.html { render :action => 'new' }
      format.js
    end
  end
  
  def edit
  end

  def update
    @category.update_attributes!(params[:category])
    flash[:notice] = 'Category updated'
    respond_to do |format|
      format.html { redirect_to cms_admin_categories_path }
      format.js
    end
  rescue ActiveRecord::RecordInvalid => e
    @category = e.record
    respond_to do |format|
      format.html { render :action => 'edit' }
      format.js
    end
  end
  
  def show
    
  end
  
  def destroy
    @category.destroy
    flash[:notice] = 'Category deleted'
    redirect_to cms_admin_categories_path
  end

protected
  
  def load_category
    @category = CmsCategory.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render :text => 'Item not found', :status => 404
  end
  
end