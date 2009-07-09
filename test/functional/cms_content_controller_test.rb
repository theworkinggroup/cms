require 'test_helper'

class CmsContentControllerTest < ActionController::TestCase
  
  def test_get_sitemap
    get :sitemap, :format => 'xml'
    assert_response :success
    assert assigns(:cms_pages)
  end
  
  def test_default_404_page
    get :show, :path => %w(some non existing page)
    assert_response 404
    assert !assigns(:cms_page)
  end
  
  def test_custom_404_page
    cms_page = CmsPage.create!(
      :cms_layout => cms_layouts(:default),
      :label      => '404 Page',
      :slug       => '404'
    )
    get :show, :path => %w(some non existing page)
    assert_response 404
    assert assigns(:cms_page)
  end
  
end
