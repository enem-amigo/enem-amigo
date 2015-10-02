class AddTextToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :text, :text
  end
end
