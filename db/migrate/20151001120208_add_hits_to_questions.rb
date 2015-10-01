class AddHitsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :hits, :integer
  end
end
