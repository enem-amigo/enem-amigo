class CreateAlternatives < ActiveRecord::Migration

  def change
    create_table :alternatives do |t|
      t.belongs_to :question, index: true
      t.string :letter
      t.string :description

      t.timestamps null: false
    end
  end

end