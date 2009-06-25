require 'test_helper'

class CmsLayoutTest < ActiveSupport::TestCase

  def test_tag_uniqueness
    layout = cms_layouts(:identical_tags)
    assert_equal 3, layout.tags.size
    tag_signatures = %w(cms_block:my_block_1:text cms_block:my_block_2:integer cms_block:my_block_3:boolean)
    layout.tags.each do |tag|
      assert tag_signatures.member?(tag.tag_signature)
      assert_equal tag.class, CmsTag::Block
    end
  end

end
