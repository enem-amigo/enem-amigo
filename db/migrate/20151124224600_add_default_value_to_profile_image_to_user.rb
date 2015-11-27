class AddDefaultValueToProfileImageToUser < ActiveRecord::Migration
  def change
    change_column_default(:users, :profile_image_file_name, "")
  end
end
