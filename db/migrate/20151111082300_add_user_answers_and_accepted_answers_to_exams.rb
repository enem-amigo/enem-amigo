class AddUserAnswersAndAcceptedAnswersToExams < ActiveRecord::Migration
  def change
    add_column :exams, :user_answers, :text
    add_column :exams, :accepted_answers, :integer
  end
end
