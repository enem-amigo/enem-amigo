class AddDefaultValuesToBattlePoints < ActiveRecord::Migration
  def change
    change_column_default(:users, :battle_points, 0)
  end
end
