class AddIndexToQuestions < ActiveRecord::Migration

  def change
    add_index :questions, :number
    add_index :questions, :year
  end

end