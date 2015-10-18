class CreateTopics < ActiveRecord::Migration
	def change
		create_table :topics do |t|
			t.string :name
			t.integer :question_id
			t.datetime :last_post_at
		end
	end
end