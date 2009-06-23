require 'test_helper'

class CmsBlockTest < ActiveSupport::TestCase
  
  def test_tag_parsing    
    layout = cms_layouts(:default)
    assert_equal 2, layout.tags.size
  end
  
end
