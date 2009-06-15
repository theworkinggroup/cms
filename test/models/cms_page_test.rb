require 'test_helper'

class CmsPageTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    CmsBlock.all.each do |block|
      assert block.valid?
    end
  end
end
