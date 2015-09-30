require 'test_helper'
include SessionsHelper

class QuestionsControllerTest < ActionController::TestCase

  def setup
    @user = users(:renata)
    @another_user = users(:joao)
    @admin = users(:admin)
    @request.env['HTTP_REFERER'] = 'http://test.host/#'
  end

  test 'should get new question if user is admin' do
    log_in @admin
    get :new
    assert_response :success
  end

  test 'should not get new question if there is no user logged in' do
    log_in @user
    log_out
    get :new
    assert_response :redirect
  end

  test 'should not get new question if user is not admin' do
    log_in @user
    get :new
    assert_response :redirect
  end

  test 'should get index of questions if user is logged in' do
    log_in @user
    get :index
    assert_response :success
  end

  test 'should not get index of questions if user is not logged in' do
    log_in @user
    log_out
    get :index
    assert_response :redirect
  end

  test 'should get question page' do
    log_in @user
    @question = create_question
    get :show, id: @question.id
    assert_response :success
  end

  test 'should points be incremented if user marks wrong answer' do
    log_in @another_user
    @question = create_question
    point = @another_user.points
    post :answer, id: @question.id, alternative: @question.right_answer.next

    assert_equal point, current_user.points
  end

  test 'should points be incremented if user marks right answer' do
    log_in @another_user
    @question = create_question
    point = @another_user.points
    post :answer, id: @question.id, alternative: @question.right_answer

    assert_equal point + 4, current_user.points
  end

  test 'should points not be incremented if user marks right answer in question already answered' do
    log_in @another_user
    @question = create_question
    point = @another_user.points
    current_user.accepted_questions.push(@question.id)
    post :answer, id: @question.id, alternative: @question.right_answer

    assert_equal point, current_user.points
  end

  test 'should admin can edit question' do
    log_in @admin
    @question = create_question
    get :edit, id: @question.id
    assert_response :success
  end

  test 'should regular user cannot edit question' do
    log_in @user
    @question = create_question
    get :edit, id: @question.id
    assert_response :redirect
  end

  test 'should admin can delete question' do
    log_in @admin
    @question = create_question
    delete :destroy, id: @question.id
    assert_redirected_to questions_path
  end

  test 'should regular user cannot delete question' do
    log_in @user
    @question = create_question
    delete :destroy, id: @question.id
    assert_redirected_to :back
  end

  private

    def create_question
      @question = Question.new(area: 'matematica', enunciation: 'something', number: 001, year: 2007, right_answer: 'a')
      5.times{@question.alternatives.build}
      @question.alternatives.each do |a|
        a.letter = 'a'
        a.description = 'something'
      end
      @question.save
      @question
    end

end