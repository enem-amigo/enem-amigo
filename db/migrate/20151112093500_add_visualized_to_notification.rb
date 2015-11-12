class AddVisualizedToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :visualized, :boolean
  end
end