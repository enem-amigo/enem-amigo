class RemoveTextColumnFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :text
  end
end
