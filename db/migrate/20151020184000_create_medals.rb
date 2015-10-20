class CreateMedals < ActiveRecord::Migration
  def change
    create_table :medals do |t|
    t.string :name
    t.text  :description
    t.string :image
    t.text :achieved_instructions
    t.text :percentage_instructions

    t.timestamps null: false
    end
  end
end
