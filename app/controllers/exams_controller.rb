class ExamsController < ApplicationController

  before_action :authenticate_user

  def select_exam
  end

  def exams_statistics
  end

  def answer_exam
    questions = params[:year_exam] ? Question.where(year: params[:year_exam]) : Question.all

    if !questions.empty?
      @math_questions = questions.where(area: "matemática e suas tecnologias")
      @humans_questions = questions.where(area: "ciências humanas e suas tecnologias")
      @language_questions = questions.where(area: "linguagens, códigos e suas tecnologias")
      @nature_questions = questions.where(area: "ciências da natureza e suas tecnologias")

      auxiliar_exam = Exam.new
      auxiliar_exam.questions.push((0...@humans_questions.count).to_a.sample 22)
      auxiliar_exam.questions.push((0...@math_questions.count).to_a.sample 22)
      auxiliar_exam.questions.push((0...@language_questions.count).to_a.sample 23)
      auxiliar_exam.questions.push((0...@nature_questions.count).to_a.sample 23)

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
    else
      redirect_to_back(select_exam_path)
      if params[:year_exam]
        flash[:danger] = "Não há questões cadastradas do ano de #{params[:year_exam]}."
      else
        flash[:danger] = "Não há questões cadastradas."
      end
    end
  end

  def exam_result
    if params[:exam_id]
      @exam = Exam.find(params[:exam_id])
      @exam.questions.each do |t|
        question = Question.find(t)
        user_answer = params[:"alternative_#{question.id}"] ? params[:"alternative_#{question.id}"] : "não marcou"
        @exam.user_answers.push(user_answer)
        if(user_answer == question.right_answer)
          @exam.accepted_answers += 1
        end
      end

      current_user.exams_total_questions += @exam.questions.count
      current_user.update_attribute(:exam_performance, current_user.exam_performance + [@exam.accepted_answers])

      @exam.save
      @exam.user_answers
    else
      redirect_to_back
      flash[:danger] = "Você deve responder uma prova antes para obter seu resultado."
    end
  end

  def cancel_exam
    exam = Exam.find(params[:exam_id])
    exam.destroy
    redirect_to root_path
  end

end
