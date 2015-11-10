require 'test_helper'
include SessionsHelper

class ExamsControllerTest < ActionController::TestCase

  def setup
    @request.env['HTTP_REFERER'] = 'http://test.host/#'
    @user = users(:renata)
  end

  test "should get select_exam page when user is logged in" do
    log_in @user
    get :select_exam
    assert_response :success
  end

  test "should not get select_exam page when user is logged in" do
    get :select_exam
    assert_redirected_to login_path
  end

end
