require 'test_helper'

class CmsLayoutTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    CmsLayout.all.each do |layout|
      assert layout.valid?, layout.errors.full_messages
    end
  end
  
  def test_adding_new_block_tag_updates_associated_pages
    layout = cms_layouts(:default)
    page = cms_pages(:default)
    assert_equal layout, page.cms_layout
    assert_equal 5, layout.tags.size
    assert_equal 4, layout.tags.select{|t| ['cms_block', 'cms_page_block'].member?(t.tag_type)}.size
    assert_equal 4, page.cms_blocks.count
    
    assert_difference ['layout.tags.size', 'page.cms_blocks.count'] do
      layout.content += "{{cms_block:new_block:string}}"
      layout.save!
      layout.reload
      page.reload
      
      assert layout.tags.collect{|t| t.tag_signature}.member?('cms_block:new_block:string')
      assert page.cms_blocks.with_label('new_block')
    end
  end

end
