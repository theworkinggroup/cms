require 'test_helper'

class CmsLayoutTest < ActiveSupport::TestCase
  
  def setup
    @cms_layout = cms_layouts(:two_column_layout)
    super
  end
  
  # -- Validations ----------------------------------------------------------

  def test_validations
    # - Presence of
    assert !cms_layout(:label => '').valid?
    # - Uniqueness of
    assert !cms_layout(:label => 'Default Layout').valid?
  end
  
  # -- Relationships --------------------------------------------------------
  
  def test_has_many_pages
    assert_equal 1, @cms_layout.cms_pages.count
    assert_difference 'CmsPage.count', -1 do
      @cms_layout.destroy
    end
  end
  
  # -- Instance Methods -----------------------------------------------------
  
  def test_should_have_blocks
    assert_equal ["title:string", "left:text", "right:text"], @cms_layout.blocks 
  end
  
  
protected
  
  def cms_layout(options = {})
    CmsLayout.new({
      :parent_id => nil,
      :label => 'Layout 1',
      :content => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit'    
    }.merge(options))
  end

end
