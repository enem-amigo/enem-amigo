require     'test_helper'
class SessionsHelperTest < ActionView::TestCase

  def   setup
    @user = users(:renata)
    @another_user = User.create(name: "Errado", users_name: "errado123", level: 0, email: "")
  end

  test  "valid user is sucessfully logged"  do
    log_in @user
    assert logged_in?
    end

  test  "invalid user is not logged"  do
    log_in @another_user
    assert !logged_in?
    end

  test "logout of valid user" do
      log_in @user
      assert logged_in?
      log_out
      assert !logged_in?
  end

end