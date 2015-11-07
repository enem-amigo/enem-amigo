class AddAnsweredExamsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :answered_exams, :text
  end
end