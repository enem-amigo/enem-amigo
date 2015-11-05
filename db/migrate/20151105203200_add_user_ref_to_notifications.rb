class AddUserRefToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :user_sender, index: true
    add_reference :notifications, :user_receiver, index: true
  end
end