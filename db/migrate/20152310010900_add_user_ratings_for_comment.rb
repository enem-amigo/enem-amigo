class AddUserRatingsForComment < ActiveRecord::Migration
  def change
    add_column :comments, :user_ratings, :text
  end
end