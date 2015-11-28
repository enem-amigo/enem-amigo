class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.string :title
      t.text :paragraphs
      t.string :reference
      t.belongs_to :question
      t.timestamps null: false
    end
  end
end
