class AddUsersHitsToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :users_hits, :integer, default: 0
  end
end