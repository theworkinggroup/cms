require 'test_helper'

class CmsBlockTest < ActiveSupport::TestCase
  
  def test_tag_parsing
    
    CmsTag::Tags.tags('blah', 'meh', :butt => 2, :gar => 4)
    
    layout = cms_layouts(:default)
    assert_equal 2, layout.tags.size
  end
  
end
