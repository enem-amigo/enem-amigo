class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    t.text :message
    t.string :image

    t.timestamps null: false
    end
  end
end
