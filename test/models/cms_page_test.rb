require 'test_helper'

class CmsPageTest < ActiveSupport::TestCase
  
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
    assert page.published_at < Time.now.utc
    assert page.unpublished_at.nil?
    assert page.is_published?
    
    page.update_attribute(:published_at, 5.days.from_now)
    assert !page.is_published?
    
    page.publish!
    assert page.is_published?
    
    page.unpublish!
    assert !page.is_published?
  end
  
end
