class ExamsController < ApplicationController

  include ExamsHelper

  def random_exam
    if current_user.answered_exams.empty?
      if Exam.all.count != 0
        @exam = Exam.first
      else
        @exam = generate_random_exam
      end
    else
      exam_id = current_user.answered_exams.max + 1
      if Exam.where(id: exam_id).empty?
        @exam = generate_random_exam
      else
        @exam = Exam.find(exam_id)
      end
    end
  end

  def exam_result
  end

end