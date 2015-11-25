require 'test_helper'
include SessionsHelper

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
    current_user.update_attribute(:points,8)
    new_level = find_level current_user.points
    assert_not_equal new_level, current_user.level
  end

  test "should user not levels up if he does not get certain points" do
    current_user.update_attribute(:points,2)
    actual_level = find_level current_user.points
    current_user.update_attribute(:points,3)
    new_level = find_level current_user.points
    assert_equal new_level, actual_level
  end

  test "should top10 takes only 10 users" do
    word = "a"
    20.times { create_user word.next , word.next! }
    top = top10
    assert_equal top.count, 10
  end

  private

    def create_user nickname, email
      @user = User.new(nickname: nickname, name: 'New User', email: email + '@email.com', password: '12345678', password_confirmation: '12345678')
      @user.save
      puts @user.errors.full_messages
    end

end