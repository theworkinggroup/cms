require 'test_helper'

class CmsCategoryItemTest < ActiveSupport::TestCase
  
  def setup
    @category_item = cms_category_items(:sample_category_item)
    super
  end

  def test_fixtures_validity
    CmsCategoryItem.all.each do |category_item|
      assert category_item.valid?
    end
  end

  def test_should_create_category
    assert_difference 'CmsCategoryItem.count', 1 do
      CmsCategoryItem.create(category_item_params)
    end
  end

  # -- Validations ----------------------------------------------------------
  
  def test_validations
    assert_no_difference 'CmsCategoryItem.count' do
      c = CmsCategoryItem.create
      assert c.errors.on(:item_id)
      assert c.errors.on(:item_type)
      assert c.errors.on(:cms_category_id)
    end
  end
  
  # -- Relationships --------------------------------------------------------

  def test_should_belong_to_cms_category
    assert @category_item.cms_category.is_a?(CmsCategory)
  end
  
  def test_should_belong_to_item
    assert @category_item.item.is_a?(CmsAttachment)
  end

  # -- Named Scope ----------------------------------------------------------
  
  def test_named_scope_of_type
    assert_equal 1, CmsCategoryItem.of_type(:cms_attachment).count
  end
  
protected

  def category_item_params(options = {})
    {
      :cms_category => cms_categories(:documents),
      :item => cms_attachments(:attachment)
    }.merge(options)
  end
  
end