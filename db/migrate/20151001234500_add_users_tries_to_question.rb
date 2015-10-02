class AddUsersTriesToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :users_tries, :integer, default: 0
  end
end