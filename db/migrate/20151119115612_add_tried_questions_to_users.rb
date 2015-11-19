class AddTriedQuestionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tried_questions, :text
  end
end
