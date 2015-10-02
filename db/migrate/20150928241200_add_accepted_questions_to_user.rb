class AddAcceptedQuestionsToUser < ActiveRecord::Migration
  def change
    add_column :users, :accepted_questions, :text
  end
end
