module ExamsHelper

  def fill_user_answers exam
    exam.questions.each do |t|
      question = Question.find(t)
      user_answer = params[:"alternative_#{question.id}"] ? params[:"alternative_#{question.id}"] : "não marcou"
      exam.user_answers.push(user_answer)
      if(user_answer == question.right_answer)
        exam.accepted_answers += 1
      end
    end
    exam
  end

  def push_questions_auxiliar questions
    @math_questions = questions.where(area: "matemática e suas tecnologias")
    @humans_questions = questions.where(area: "ciências humanas e suas tecnologias")
    @language_questions = questions.where(area: "linguagens, códigos e suas tecnologias")
    @nature_questions = questions.where(area: "ciências da natureza e suas tecnologias")

    auxiliar_exam = Exam.new
    auxiliar_exam.questions.push((0...@humans_questions.count).to_a.sample 22)
    auxiliar_exam.questions.push((0...@math_questions.count).to_a.sample 22)
    auxiliar_exam.questions.push((0...@language_questions.count).to_a.sample 23)
    auxiliar_exam.questions.push((0...@nature_questions.count).to_a.sample 23)
    auxiliar_exam
  end

  def push_questions auxiliar_exam
    @exam = Exam.new

    for i in 0...4
      auxiliar_exam.questions[i].each do |a|
        if i == 0
          single_question = @humans_questions[a]
        elsif i == 1
          single_question = @math_questions[a]
        elsif i == 2
          single_question = @language_questions[a]
        elsif i == 3
          single_question = @nature_questions[a]
        end

        @exam.questions.push(single_question.id)
        @exam.right_answers.push(single_question.right_answer)
      end
    end

    @exam.save
    @exam
  end

end