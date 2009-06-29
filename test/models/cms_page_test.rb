require 'test_helper'

class CmsPageTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    CmsPage.all.each do |page|
      assert page.valid?, page.errors.full_messages
    end
  end
  
  def test_page_rendering
    page = cms_pages(:default)
    assert_equal 3, page.cms_blocks.count
    assert_equal '/page_block:default//page_block:footer/', page.render_content
  end
  
  def test_complex_nested_rendering
    page = cms_pages(:complex)
    assert_equal 4, page.cms_blocks.count
    assert_equal "/page_block:left_column/ /complex snippet//page_block:right_column/ <%= render :partial => 'complex_page/example' %>/complex snippet//page_block:footer/", page.render_content
  end
  
  def test_page_content
    page = cms_pages(:default)
    assert_equal page.content, page.render_content
  end
  
  def test_cms_block_content_method
    page = cms_pages(:default)
    assert !page.cms_block_content(:header, :content_string).blank?
    assert page.cms_block_content(:bogus_label, :content_string).blank?
  end
  
end
