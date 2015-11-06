class AddBattleRefToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :battle, index: true
  end
end