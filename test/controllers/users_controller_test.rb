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

  test 'should get create user' do
    post :create, user: { nickname: 'newuser', name: 'New User', email: 'newuser@email.com', password: '12345678', password_confirmation: '12345678' }
    assert_equal User.last.email, 'newuser@email.com'
  end

  test 'should not save user if password is too short' do
    post :create, user: { nickname: 'newuser', name: 'New User', email: 'newuser@email.com', password: '123456', password_confirmation: '123456' }
    assert_not_equal User.last.email, 'newuser@email.com'
  end

  test "should update user" do
    log_in @user
    old_name = @user.name
    patch :update, id: @user.id, user: { name: "New Name", password: '12345678', password_confirmation: '12345678' }
    @user.reload
    assert_not_equal old_name, @user.name
  end

  test "should not update user if password is not passed" do
    log_in @user
    old_name = @user.name
    patch :update, id: @user.id, user: { name: "New Name" }
    @user.reload
    assert_equal old_name, @user.name
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

  test "should get ranking if user is or not logged in" do
    log_in @user
    get :ranking
    assert_response :success
    log_out
    get :ranking
    assert_response :success
  end

  test "should ranking order users from more to less points" do
    @user.update_attribute(:points,1)
    @another_user.update_attribute(:points,3)
    @admin.destroy
    get :ranking
    first_user = assigns(:users).first
    second_user = assigns(:users).second
    assert first_user.points > second_user.points
  end

  test "should delete_profile_image redirects to user profile if user is logged in" do
    log_in @user
    get :delete_profile_image
    assert_redirected_to user_path(@user.id)
  end

  test "should delete_profile_image redirects to login if user is logged in" do
    get :delete_profile_image
    assert_redirected_to login_path
  end

  test "should delete_profile_image deletes profile image of user" do
    log_in @user
    @user.update_attribute(:profile_image_file_name,"profile.png")
    get :delete_profile_image
    @user.reload
    assert_equal @user.profile_image_file_name, ""
  end

end