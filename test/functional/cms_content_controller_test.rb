require 'test_helper'

class CmsContentControllerTest < ActionController::TestCase
  
  def test_get_sitemap
    get :sitemap, :format => 'xml'
    assert_response :success
    assert assigns(:cms_pages)
  end
  
end
