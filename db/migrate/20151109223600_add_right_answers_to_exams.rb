class AddRightAnswersToExams < ActiveRecord::Migration
  def change
    add_column :exams, :right_answers, :text
  end
end
