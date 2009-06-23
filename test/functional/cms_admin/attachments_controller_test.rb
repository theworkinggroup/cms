require 'test_helper'

class CmsAdmin::AttachmentsControllerTest < ActionController::TestCase
  
  def setup
    http_auth
  end
  
  def test_get_index
    get :index
    assert_response :success
    assert assigns(:attachments)
  end
  
  def test_get_new
    get :new
    assert_response :success
  end
  
  def test_get_edit
    get :edit, :id => cms_attachments(:attachment)
    assert_response :success
    assert assigns(:attachment)
  end
  
  def test_create
    assert_difference 'CmsAttachment.count', 1 do
      post :create, :attachment => {
        :label => 'Test File',
        :description => 'This is a file',
        :file => fixture_file_upload('files/upload_file.txt', 'text/plain')
      }
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Attachment created', flash[:notice]
    end
  end
  
  def test_update
    attachment = cms_attachments(:attachment)
    put :update, :id => attachment, :attachment => {
      :label => 'New Label',
      :description => 'New Description'
    }
    attachment.reload
    assert_equal 'New Label', attachment.label
    assert_equal 'New Description', attachment.description
    assert_equal 'Attachment updated', flash[:notice]
  end
  
  def test_destroy
    assert_difference 'CmsAttachment.count', -1 do
      delete :destroy, :id => cms_attachments(:attachment)
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Attachment removed', flash[:notice]
    end
  end
  
end