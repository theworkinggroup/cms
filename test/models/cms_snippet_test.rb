require 'test_helper'

class CmsSnippetTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    CmsSnippet.all.each do |snippet|
      assert snippet.valid?, snippet.errors.full_messages
    end
  end
  
  def test_get_content
    assert_equal cms_snippets(:complex).content, CmsSnippet.content_for('complex_snippet')
    assert_equal '', CmsSnippet.content_for('nonexistant_snippet')
  end
  
end
