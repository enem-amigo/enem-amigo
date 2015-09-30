require 'test_helper'
include SessionsHelper

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:renata)
    @another_user = users(:joao)
    @admin = users(:admin)
    @request.env['HTTP_REFERER'] = 'http://test.host/#'
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should get index of users' do
    log_in @user
    get :index
    assert_response :success
  end

  test 'should get user profile' do
    log_in @user
    get :show, id: @user.id
    assert_response :success
  end

  test 'should user can see her own edit page' do
    log_in @user
    get :edit, id: @user.id
    assert_response :success
  end

  test 'should user cannot see other user''s edit page' do
    log_in @another_user
    get :edit, id: @user.id
    assert_response :redirect
  end

  test 'should admin can edit any user profile' do
    log_in @admin
    get :edit, id: @user.id
    assert_response :success
    get :edit, id: @another_user.id
    assert_response :success
  end

  test 'should a regular user can delete his own profile' do
    log_in @another_user
    delete :destroy, id: @another_user.id
    assert_redirected_to users_path
  end

  test 'should a regular user cannot delete other user' do
    log_in @user
    delete :destroy, id: @another_user.id
    assert_redirected_to :back
  end

  test 'should admin can delete any user' do
    log_in @admin
    delete :destroy, id: @user.id
    assert_redirected_to users_path
    @request.env['HTTP_REFERER'] = 'http://test.host/#'
    delete :destroy, id: @another_user.id
    assert_redirected_to users_path
  end

end