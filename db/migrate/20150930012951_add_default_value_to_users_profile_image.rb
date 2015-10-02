class AddDefaultValueToUsersProfileImage < ActiveRecord::Migration
  def change
    change_column_default(:users, :profile_image, 'default')
  end
end
