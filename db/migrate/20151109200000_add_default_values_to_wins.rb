class AddDefaultValuesToWins < ActiveRecord::Migration
  def change
    change_column_default(:users, :wins, 0)
  end
end
