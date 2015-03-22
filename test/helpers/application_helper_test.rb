require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test '#full_title helper' do
    assert_equal full_title, 'Grapevine' # Case when passing in nothing as page_title
    assert_equal full_title('Help'), 'Help | Grapevine'
  end
end
