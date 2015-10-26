require 'test_helper'
class UsersHelperTest < ActionView::TestCase

  def setup
    @user = users(:renata)
    log_in @user
  end

  test "should find_level gets level of user" do
    find_level current_user.points
    assert_equal current_user.level, @user_level
  end

  test "should update_user_level updates level of user" do
    previous_level = find_level current_user.points
    @user_level = previous_level + 1
    update_user_level
    assert_not_equal previous_level, current_user.level
  end

  test "should user levels up if he gets certain points" do
    current_user.update_attribute(:points,25)
    new_level = find_level current_user.points
    assert_not_equal new_level, current_user.level
  end

  test "should user not levels up if he does not get certain points" do
    current_user.update_attribute(:points,5)
    new_level = find_level current_user.points
    assert_equal new_level, current_user.level
  end

end