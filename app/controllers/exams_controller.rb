include ExamsHelper

class ExamsController < ApplicationController

  before_action :authenticate_user

  def select_exam
  end

  def exams_statistics
  end

  def answer_exam
    questions = params[:year_exam] ? Question.where(year: params[:year_exam]) : Question.all

    if !questions.empty?
      auxiliar_exam = push_questions_auxiliar(questions)
      @exam = push_questions(auxiliar_exam)
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
      @exam = fill_user_answers(@exam)

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
