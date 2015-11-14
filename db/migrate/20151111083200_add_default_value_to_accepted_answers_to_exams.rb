class AddDefaultValueToAcceptedAnswersToExams < ActiveRecord::Migration
  def change
    change_column_default(:exams, :accepted_answers, 0)
  end
end
