require 'test_helper'

class CmsAdmin::CategoriesControllerTest < ActionController::TestCase
  
  def setup
    http_auth
  end
    
  def test_get_index
    get :index
    assert_response :success
    assert assigns(:categories)
  end
  
  
  def test_get_new
    get :new
    assert_response :success
  end
  
  def test_get_edit
    get :edit, :id => cms_categories(:default)
    assert_response :success
    assert assigns(:category)
  end
  
  def test_create
    assert_difference 'CmsCategory.count', 1 do
      post :create, :category => {
        :label => 'Category 1',
        :description => 'This is a category',
      }
    end
    assert_redirected_to cms_admin_categories_path
    assert_equal 'Category created', flash[:notice]
  end
  
  def test_create_fail
    assert_no_difference 'CmsCategory.count' do
      post :create, :category => {
        :label => '',
        :description => 'This is a category',
      }
    end
    assert_response :success
    assert_template 'new'
    assert assigns(:category).errors.on(:label)
  end
  
  def test_update
    category = cms_categories(:default)
    put :update, :id => category, :category => {
      :label => 'Category 2',
      :description => 'New Description'
    }
    assert_redirected_to cms_admin_categories_path
    category.reload
    assert_equal 'Category 2', category.label
    assert_equal 'New Description', category.description
    assert_equal 'Category updated', flash[:notice]
  end
  
  def test_update_fail
    category = cms_categories(:default)
    put :update, :id => category, :category => {
      :label => '',
      :description => 'New Description'
    }
    assert_response :success
    assert_template 'edit'
    assert assigns(:category).errors.on(:label)
  end
  
  def test_destroy
    assert_difference 'CmsCategory.count', -1 do
      delete :destroy, :id => cms_categories(:default)
      assert_redirected_to cms_admin_categories_path
      assert_equal 'Category deleted', flash[:notice]
    end
  end
end