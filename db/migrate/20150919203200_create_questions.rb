class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :year
      t.string :area
      t.integer :number
      t.string :enunciation
      t.string :reference
      t.string :image

      t.timestamps null: false
    end
  end
end