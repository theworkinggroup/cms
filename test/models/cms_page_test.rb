require 'test_helper'

class CmsPageTest < ActiveSupport::TestCase
  
  def test_initialization
    page = CmsPage.new
    assert page.cms_layout
    assert_equal cms_layouts(:default), CmsLayout.first
    assert_equal cms_layouts(:default), page.cms_layout
  end
    
  def test_initialization_with_parent_page
    assert cms_layouts(:nested), cms_pages(:complex).cms_layout
    page = CmsPage.new(:parent => cms_pages(:complex))
    assert page.cms_layout
    assert_equal cms_pages(:complex).cms_layout, page.cms_layout
  end
    
  def test_fixtures_validity
    CmsPage.all.each do |page|
      assert page.valid?, page.errors.full_messages
    end
  end
  
  def test_page_finder_helper
    page = cms_pages(:default)
    assert_equal page, CmsPage[page.slug]
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
  
  def test_publishing
    page = cms_pages(:default)
    assert page.published?
    page.update_attribute(:published, false)
    assert !page.published?
  end
  
  def test_excluding_from_nav
    page = cms_pages(:default)
    assert !page.excluded_from_nav?
    page.update_attribute(:excluded_from_nav, true)
    assert page.excluded_from_nav?
  end
end
