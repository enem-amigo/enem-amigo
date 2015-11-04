class AddUserRatingsForPost < ActiveRecord::Migration
  def change
    add_column :posts, :user_ratings, :text
  end
end