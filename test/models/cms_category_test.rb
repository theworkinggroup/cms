require 'test_helper'

class CmsCategoryTest < ActiveSupport::TestCase
  
  def setup
    @category = cms_categories(:default)
    super
  end
  
  def test_fixtures_validity
    CmsCategory.all.each do |category|
      assert category.valid?
    end
  end

  def test_should_create_category
    assert_difference 'CmsCategory.count', 1 do
      CmsCategory.create(category_params)
    end
  end

  # -- Validations ----------------------------------------------------------
  
  def test_validations
    assert_no_difference 'CmsCategory.count' do
      c = CmsCategory.create(category_params(:label =>'', :slug =>''))
      assert c.errors.on(:label)
      assert c.errors.on(:slug)
      c = CmsCategory.create(category_params(:slug => @category.slug))
      assert c.errors.on(:slug)
    end
  end
  
  # -- Relationships --------------------------------------------------------
  
  def test_should_have_many_items
    assert_equal 1, @category.items.count
  end
  
  # -- Instance Methods -----------------------------------------------------
  
  def test_should_set_slug_if_blank
    c = CmsCategory.new(category_params(:slug => ''))
    assert c.valid?
    assert_equal 'whitepapers', c.slug
    c = CmsCategory.new(category_params)
    assert c.valid?
    assert_equal 'whitepapers-list', c.slug
  end
  
protected

  def category_params(options = {})
    {
      :label => 'Whitepapers',
      :slug => 'whitepapers-list',
      :description => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.'
    }.merge(options)
  end
  
end
