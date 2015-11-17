class AddExamPerformanceAndExamsTotalQuestionsToUser < ActiveRecord::Migration
  def change
    add_column :users, :exam_performance, :text
    add_column :users, :exams_total_questions, :integer, default: 0
  end
end