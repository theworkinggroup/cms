class CmsAdmin::SectionsController < CmsAdmin::BaseController
  
  def show
    @page = CmsPage.sections.find_by_id(params[:id])
    @pages = @page.children.paginate :page => params[:page]
    
    # attempt to singularize section name
    @section_label = @page.label.singularize
  end
  
  def test_get_show
    get :show, :id => cms_pages(:complex_page)
    assert_response :success
    assert assigns(:pages)
  end
  
end
