require 'test_helper'

class CmsPageTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    CmsBlock.all.each do |block|
      assert block.valid?
    end
  end
  
  def test_rendering
    page = cms_pages(:default)
    raise page.content.to_yaml
  end
  
end
