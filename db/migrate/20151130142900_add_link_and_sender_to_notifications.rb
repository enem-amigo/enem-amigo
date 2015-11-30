class AddLinkAndSenderToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :link, :string
    add_column :notifications, :sender, :string
  end
end