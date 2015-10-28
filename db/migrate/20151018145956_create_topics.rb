class CreateTopics < ActiveRecord::Migration
	def change
		create_table :topics do |t|
			t.string :name
			t.integer :question_id
			t.text :description

			t.timestamps null: false
		end
	end
end