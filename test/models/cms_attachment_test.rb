require 'test_helper'

class CmsAttachmentTest < ActiveSupport::TestCase

  def test_fixtures_validity
    CmsAttachment.all.each do |attachment|
      assert attachment.valid?
    end
  end
  
  def test_named_scope_in_category
    assert_equal 1, CmsAttachment.in_category(cms_categories(:category_2)).size
    assert_equal 1, CmsAttachment.in_category(cms_categories(:category_2).id).size
  end
  
end
