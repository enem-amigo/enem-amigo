require 'test_helper'
include SessionsHelper

class StaticPagesControllerTest < ActionController::TestCase

  def setup
    @user = users(:renata)
    @another_user = users(:joao)
    @admin = users(:admin)
    @request.env['HTTP_REFERER'] = 'http://test.host/'
  end

  test 'should get home page if user is logged in' do
    log_in @user
    get :home
    assert_response :success
  end

  test 'should not get home page if user is not logged in' do
    get :home
    assert_redirected_to login_path
  end

  test 'should get help page if user is logged in' do
    log_in @user
    get :help
    assert_response :success
  end

  test 'should get help page if user is not logged in' do
    get :help
    assert_response :success
  end

  test 'should get about page if user is logged in' do
    log_in @user
    get :about
    assert_response :success
  end

  test 'should get about page if user is not logged in' do
    get :about
    assert_response :success
  end

  test 'should not get server error page if an exception is not thrown' do
    log_in @user
    get :server_error

    assert_redirected_to :back
  end

  test 'should not get server error page if user is not logged in' do
    get :server_error
    assert_redirected_to root_path
  end

end