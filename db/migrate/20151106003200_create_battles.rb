class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
    t.text :player_1_answers
    t.text :player_2_answers
    t.string :category
    t.integer :player_1_time
    t.integer :player_2_time
    t.boolean :player_1_start
    t.boolean :player_2_start

    t.timestamps null: false
    end
  end
end
