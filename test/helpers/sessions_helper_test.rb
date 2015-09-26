require     'test_helper'
class SessionsHelperTest < ActionView::TestCase

  def   setup
    @user = users(:renata)
  end

  test  "valid user is sucessfully logged"  do
    log_in @user
    assert logged_in?
    end

end