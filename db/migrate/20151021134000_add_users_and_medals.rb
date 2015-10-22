class AddUsersAndMedals < ActiveRecord::Migration
  def self.up
    create_table :medals_users do |t|
      t.references :medal, :user
    end
  end

  def self.down
    drop_table :medals_users
  end
end