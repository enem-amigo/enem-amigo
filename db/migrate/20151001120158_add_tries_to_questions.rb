class AddTriesToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :tries, :integer
  end
end
