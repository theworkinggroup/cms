require 'test_helper'

class CmsLayoutTest < ActiveSupport::TestCase
  
  def test_tag_parcing
    layout = cms_layouts(:default)
    assert_equal 5, layout.tags.size
    assert layout.is_extendable?
  end
  
  def test_tag_uniqueness
    layout = cms_layouts(:identical_tags)
    assert_equal 3, layout.tags.size
    tag_signatures = %w(cms_block:my_block_1:text cms_block:my_block_2:integer cms_block:my_block_3:boolean)
    layout.tags.each do |tag|
      assert tag_signatures.member?(tag.tag_signature)
      assert_equal tag.class, CmsTag::Block
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
      layout.save
      layout.reload
      page.reload
      
      assert layout.tags.collect{|t| t.tag_signature}.member?('cms_block:new_block:string')
      assert page.cms_blocks.with_label('new_block')
    end
  end

end
