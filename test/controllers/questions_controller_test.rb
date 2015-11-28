require 'test_helper'
include SessionsHelper

class QuestionsControllerTest < ActionController::TestCase

  def setup
    @user = users(:renata)
    @another_user = users(:joao)
    @admin = users(:admin)
    @math_question = create_question_with_params(2011,"matemática e suas tecnologias",42)
    @human_question = create_question_with_params(2014,"ciências humanas e suas tecnologias",23)
    @language_question = create_question_with_params(2011,"linguagens, códigos e suas tecnologias",24)
    @nature_question = create_question_with_params(2014,"ciências da natureza e suas tecnologias",25)
    @request.env['HTTP_REFERER'] = 'http://test.host/#'
  end

  test "should get show if user is logged in" do
    log_in @user
    get :show, id: @math_question.id
    assert_response :success
  end

  test "should not get show if user is not logged in" do
    get :show, id: @math_question.id
    assert_redirected_to login_path
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

  test 'should points be incremented if user marks wrong answer' do
    log_in @another_user
    @question = create_question
    point = @another_user.points
    post :answer, id: @question.id, alternative: @question.right_answer.next

    assert_equal point, current_user.points
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

  test "should get all area pages" do
    log_in @user
    get :math
    assert_response :success
    get :humans
    assert_response :success
    get :languages
    assert_response :success
    get :nature
    assert_response :success
  end

  test "should each area page return only questions for that area" do
    log_in @user

    get :math
    assigns(:questions).each do |q|
      assert q.area == "matemática e suas tecnologias"
    end
    get :humans
    assigns(:questions).each do |q|
      assert q.area == "ciências humanas e suas tecnologias"
    end
    get :languages
    assigns(:questions).each do |q|
      assert q.area == "linguagens, códigos e suas tecnologias"
    end
    get :nature
    assigns(:questions).each do |q|
      assert q.area == "ciências da natureza e suas tecnologias"
    end
  end

  test 'should upload a json file to create a set of questions' do
    log_in @admin
    questions_count = Question.all.count
    json_file = fixture_file_upload('files/template.json', 'application/json')
    post :upload_questions, questions_file: json_file
    assert questions_count < Question.all.count
  end

  test 'should throw an exception when no question file is uploaded' do
    log_in @admin
    assert_raises(Exception) { post :upload_questions }
  end

  test 'should upload a text file to persist data from old candidates' do
    log_in @admin
    candidates_count = Candidate.all.count
    file = fixture_file_upload('files/candidates_data.txt', 'application/text')
    post :upload_candidates_data, candidates_data_file: file
    assert candidates_count < Candidate.all.count
  end

  test 'should throw an exception when no candidates data file is uploaded' do
    log_in @admin
    assert_raises(Exception) { post :upload_candidates_data }
  end

  private

    def create_question
      @question = Question.new(area: 'matematica', enunciation: 'something', number: 021, year: 2007, right_answer: 'a')
      5.times{@question.alternatives.build}
      @question.alternatives.each do |a|
        a.letter = 'a'
        a.description = 'something'
      end
      @question.save
      @question
    end

    def create_question_with_params year, area, number
      @question = Question.new(area: area, enunciation: 'something', number: number, year: year, right_answer: 'a', image: "", reference: "")
      5.times{@question.alternatives.build}
      @question.alternatives.each do |a|
        a.letter = 'a'
        a.description = 'something'
      end
      @question.save
      @question
    end

end