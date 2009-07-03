require 'test_helper'

class CmsAttachmentTest < ActiveSupport::TestCase

  def test_fixtures_validity
    CmsAttachment.all.each do |attachment|
      assert attachment.valid?
    end
  end

  # -- Relationships --------------------------------------------------------
  
  def test_should_have_many_category_items
    assert 1, cms_attachments(:attachment).cms_category_items.count
    assert cms_attachments(:attachment).cms_category_items.first.is_a?(CmsCategoryItem)
  end
  
  def test_should_have_many_categories
    assert 1, cms_attachments(:attachment).cms_categories.count
    assert cms_attachments(:attachment).cms_categories.first.is_a?(CmsCategory)
  end
  
end
