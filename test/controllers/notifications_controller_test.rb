require 'test_helper'

include SessionsHelper

class NotificationsControllerTest < ActionController::TestCase

  def setup
    @user = users(:renata)
    @another_user = users(:joao)
    @battle = battles(:first_battle)
    @battle.generate_questions
    @battle.update_attributes(player_1: @user, player_2: @another_user)
    @notification = notifications(:notification)
    @notification.update_attributes(user: @user, battle: @battle)
    log_in @user
  end


  test 'should get notifications and check them as visualized' do
    log_in @user
    current_user.notifications << @notification
    xhr :get, :read
    assert_equal current_user.notifications.where(visualized: false).count, 0
  end

  test 'should get index if user is logged in' do
      get :index
      assert_response :success
  end

end