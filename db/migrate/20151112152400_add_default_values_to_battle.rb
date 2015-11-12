class AddDefaultValuesToBattle < ActiveRecord::Migration
  def change
    change_column_default(:battles, :player_1_start, false)
    change_column_default(:battles, :player_2_start, false)
    change_column_default(:battles, :processed, false)
  end
end
