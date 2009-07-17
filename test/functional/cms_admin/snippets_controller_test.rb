require 'test_helper'

class CmsAdmin::SnippetsControllerTest < ActionController::TestCase
  
  def setup
    http_auth
  end
  
  def test_get_index
    get :index
    assert_response :success
    assert assigns(:snippets)
  end
  
  def test_get_new
    get :new
    assert_response :success
  end
  
  def test_get_edit
    get :edit, :id => cms_snippets(:default)
    assert_response :success
    assert assigns(:snippet)
  end
  
  def test_create
    assert_difference 'CmsSnippet.count' do
      post :create, :snippet => {
        :label    => 'test_snippet',
        :content  => 'test content'
      }
      assert_response :redirect
      assert_redirected_to :action => :edit
      assert_equal 'Snippet created', flash[:notice]
    end
  end
  
  def test_update
    snippet = cms_snippets(:default)
    
    put :update, :id => snippet, :snippet => {
      :label    => 'new_test_label',
      :content  => 'new test content'
    }
    assert_response :redirect
    assert_redirected_to :action => :edit
    assert_equal 'Snippet updated', flash[:notice]
      
    snippet.reload
    assert_equal 'new_test_label', snippet.label
    assert_equal 'new test content', snippet.content
  end
  
  def test_destroy
    assert_difference 'CmsSnippet.count', -1 do
      delete :destroy, :id => cms_snippets(:default)
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Snippet removed', flash[:notice]
    end
  end
  
end
