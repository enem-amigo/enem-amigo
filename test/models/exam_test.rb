class ExamTest < ActiveSupport::TestCase

  test "should exam created be valid" do
    create_exam
    assert @exam.valid?
  end

  test "should save question with all attributes" do
    create_exam
    assert @exam.save
  end

  test "should not create exam with no right_answers" do
    create_exam
    @exam.right_answers = []
    assert_not @exam.save
  end

  test "should not create exam with no questions" do
    create_exam
    @exam.questions = []
    assert_not @exam.save
  end

  private

    def create_exam
      @exam = Exam.new(questions: [[1,2],[4,5],[8,3],[0]], right_answers: [['d','c'],['e','f'],['a','b'],['e']] )
    end

end
