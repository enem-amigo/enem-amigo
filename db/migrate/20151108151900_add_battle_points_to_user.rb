class AddBattlePointsToUser < ActiveRecord::Migration
  def change
    add_column :users, :battle_points, :integer
  end
end