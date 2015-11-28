require 'test_helper'
include SessionsHelper

class TopicsControllerTest < ActionController::TestCase

  def setup
    @request.env['HTTP_REFERER'] = 'http://test.host/#'
    @user= users(:joao)
    @admin= users(:admin)
    @topic = Topic.create(name: 'Questão 1', question_id: 1, description: 'Dúvidas e respostas')
  end

  test "should get new topic if user is not logged in" do
    get :new
    assert_redirected_to login_path
  end

  test "should not get new topic if user is not admin" do
    log_in @user
    get :new
    assert_redirected_to :back
  end

  test "should get new topic if user is admin" do
    log_in @user
    @user.update_attribute(:role_admin, true)
    get :new
    assert_response :success
  end

  test 'should get create topic' do
    log_in @admin
    post :create, topic: {name: 'Questão 1 - Prova 2010', question_id: 1, description: 'Dúvidas e respostas sobre quesão 1 da prova de 2010'}
    assert_equal Topic.last.name, 'Questão 1 - Prova 2010'
  end

  test 'should get topic show' do
    log_in @user
    get :show, id: @topic.id
    assert_response :success
  end

  test 'should get topic index' do
    log_in @user
    get :index
    assert_response :success
  end

end