class AddQuestionsAndBattles < ActiveRecord::Migration
  def self.up
    create_table :battles_questions do |t|
      t.references :battle, :question
    end
  end

  def self.down
    drop_table :battles_questions
  end
end