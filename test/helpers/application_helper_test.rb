require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  def setup
    @page_title = "page"
  end

  test "should full_title returns the title on the page if there is a page_title" do
    title = full_title @page_title
    assert title.length > 10
  end

  test "should full_title returns only the base_title if there is no page_title" do
    title = full_title
    assert_not title.length > 10
  end

end