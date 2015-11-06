class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
    t.text :player_1_answers
    t.text :player_2_answers
    t.timestamp :player_1_time
    t.timestamp :player_2_time

    t.timestamps null: false
    end
  end
end
