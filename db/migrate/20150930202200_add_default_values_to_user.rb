class AddDefaultValuesToUser < ActiveRecord::Migration
  def change
    change_column_default(:users, :points, 0)
    change_column_default(:users, :level, 0)
    change_column_default(:users, :role_admin, false)
  end
end
