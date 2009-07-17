require 'test_helper'

class CmsAttachmentTest < ActiveSupport::TestCase

  def test_fixtures_validity
    CmsAttachment.all.each do |attachment|
      assert attachment.valid?
    end
  end
  
end
