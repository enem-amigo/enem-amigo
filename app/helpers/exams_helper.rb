module ExamsHelper

  def generate_random_exam
    @exam = Exam.new
    exam_right_answers = []

    @math_questions = Question.where(area: "matemática e suas tecnologias")
    @humans_questions = Question.where(area: "ciências humanas e suas tecnologias")
    @language_questions = Question.where(area: "linguagens, códigos e suas tecnologias")
    @nature_questions = Question.where(area: "ciências da natureza e suas tecnologias")

    @exam.questions.push((0...@humans_questions.count).to_a.sample 22)
    exam_right_answers.push(generate_right_answers(@exam, 0))
    @exam.questions.push((0...@math_questions.count).to_a.sample 22)
    exam_right_answers.push(generate_right_answers(@exam, 1))
    @exam.questions.push((0...@language_questions.count).to_a.sample 23)
    exam_right_answers.push(generate_right_answers(@exam, 2))
    @exam.questions.push((0...@nature_questions.count).to_a.sample 23)
    exam_right_answers.push(generate_right_answers(@exam, 3))
    @exam.save
    @exam
  end

  def generate_exam exam_year
    exam = Question.where(year: exam_year)
  end

  def generate_right_answers exam, index
    right_answers = []
    if index == 0
      exam.questions[index].each do |t|
        right_answers.push(@humans_questions[t].right_answer)
      end
    elsif index == 1
      exam.questions[index].each do |t|
        right_answers.push(@math_questions[t].right_answer)
      end
    elsif index == 2
      exam.questions[index].each do |t|
        right_answers.push(@language_questions[t].right_answer)
      end
    elsif index == 3
      exam.questions[index].each do |t|
        right_answers.push(@nature_questions[t].right_answer)
      end
    end
    right_answers
  end
end
