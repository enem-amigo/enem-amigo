class ExamsController < ApplicationController

  include ExamsHelper

  def select_exam
  end

  def answer_exam
    questions = params[:year_exam] ? Question.where(year: params[:year_exam]) : Question.all

    exam = Exam.new
    exam.right_answers = []

    @math_questions = questions.where(area: "matemática e suas tecnologias")
    @humans_questions = questions.where(area: "ciências humanas e suas tecnologias")
    @language_questions = questions.where(area: "linguagens, códigos e suas tecnologias")
    @nature_questions = questions.where(area: "ciências da natureza e suas tecnologias")

    exam.questions.push((0...@humans_questions.count).to_a.sample 22)
    exam.right_answers.push(generate_right_answers(exam, 0))
    exam.questions.push((0...@math_questions.count).to_a.sample 22)
    exam.right_answers.push(generate_right_answers(exam, 1))
    exam.questions.push((0...@language_questions.count).to_a.sample 23)
    exam.right_answers.push(generate_right_answers(exam, 2))
    exam.questions.push((0...@nature_questions.count).to_a.sample 23)
    exam.right_answers.push(generate_right_answers(exam, 3))
    exam.save

    @exams = []
    @exams.push(exam.id)
    for i in 0...4
      exam.questions[i].each do |a|
        if i == 0
          single_question = Question.where(area: "ciências humanas e suas tecnologias")[a]
        elsif i == 1
          single_question = Question.where(area: "matemática e suas tecnologias")[a]
        elsif i == 2
          single_question = Question.where(area: "linguagens, códigos e suas tecnologias")[a]
        elsif i == 3
          single_question = Question.where(area: "ciências da natureza e suas tecnologias")[a]
        end
        @exams.push(single_question)
      end
    end

    if @exams.count == 1
      redirect_to_back(exam_result_path)
      flash[:danger] = "Não há questões cadastradas do ano de #{params[:year_exam]}."
    else
      @exams
    end
  end

  def exam_result
    @exam_user_answers = []
    @accepted_answers = 0

    @current_exam = Exam.find(params[:exam_id])

    for i in 0...4
      @current_exam.questions[i].each do |t|
        if i == 0
          question = Question.where(area: "ciências humanas e suas tecnologias")[t]
        elsif i == 1
          question = Question.where(area: "matemática e suas tecnologias")[t]
        elsif i == 2
          question = Question.where(area: "linguagens, códigos e suas tecnologias")[t]
        elsif i == 3
          question = Question.where(area: "ciências da natureza e suas tecnologias")[t]
        end

        user_answer = params[:"alternative_#{question.id}"] ? params[:"alternative_#{question.id}"] : "não marcou"
        @exam_user_answers.push(user_answer)
        if(user_answer == question.right_answer)
          @accepted_answers += 1
        end
      end
    end

    @exam_user_aswers
  end

end
