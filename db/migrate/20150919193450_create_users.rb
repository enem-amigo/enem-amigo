class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    t.string :nickname
    t.string :name
    t.string :email
    t.integer :level

    t.timestamps null: false
    end
  end
end
