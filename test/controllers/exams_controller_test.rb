require 'test_helper'
include SessionsHelper

class ExamsControllerTest < ActionController::TestCase

  def setup
    @request.env['HTTP_REFERER'] = 'http://test.host/#'
    @user = users(:renata)
    @math_question = create_question(2011,"matemática e suas tecnologias")
    @human_question = create_question(2014,"ciências humanas e suas tecnologias")
    @language_question = create_question(2011,"linguagens, códigos e suas tecnologias")
    @nature_question = create_question(2014,"ciências da natureza e suas tecnologias")
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

  test "should not get answer_exam page if user is not logged in" do
    get :answer_exam
    assert_redirected_to login_path
  end

  test "should get answer_exam page if there are questions in the database" do
    log_in @user
    get :answer_exam
    assert_response :success
  end

  test "should not get answer_exam page if there are no questions in the database" do
    log_in @user
    Question.destroy_all
    get :answer_exam
    assert_redirected_to :back
  end

  test "should exam have the same number of questions and right_answers when an exam is created" do
    log_in @user
    get :answer_exam
    last_exam = Exam.last
    assert_equal last_exam.questions.count, last_exam.right_answers.count
  end

  test "should create exam when user clicks goes to answer_exam page" do
    log_in @user
    old_exam = Exam.last
    get :answer_exam
    assert_not_equal old_exam, Exam.last
  end

  test "should create year exam if there are question for that year" do
    log_in @user
    old_exam = Exam.last
    get :answer_exam, year_exam: 2011
    new_exam = Exam.last
    assert_not_equal old_exam, new_exam
  end

  test "should not create year exam if there are no question for that year" do
    log_in @user
    old_exam = Exam.last
    get :answer_exam, year_exam: 2019
    new_exam = Exam.last
    assert_equal old_exam, new_exam
    assert_redirected_to :back
  end

  test "should right_answers not be empty when an exam is created" do
    log_in @user
    get :answer_exam
    last_exam = Exam.last
    assert_not last_exam.right_answers.empty?
  end

  test "should questions not be empty when an exam is created" do
    log_in @user
    get :answer_exam
    last_exam = Exam.last
    assert_not last_exam.questions.empty?
  end

  private
    def create_question year, area
      @question = Question.new(area: area, enunciation: 'something', number: 001, year: year, right_answer: 'a', image: "", reference: "", text: "")
      5.times{@question.alternatives.build}
      @question.alternatives.each do |a|
        a.letter = 'a'
        a.description = 'something'
      end
      @question.save
      @question
    end

end
