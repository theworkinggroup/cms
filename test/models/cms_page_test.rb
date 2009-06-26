require 'test_helper'

class CmsPageTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    CmsBlock.all.each do |block|
      assert block.valid?
    end
  end
  
  def test_cms_block_content_method
    page = cms_pages(:default)
    assert !page.cms_block_content(:html_title, :content_string).blank?
    assert page.cms_block_content(:bogus_label, :content_string).blank?
  end
  
end
