class AddRoleAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :role_admin, :boolean
  end
end