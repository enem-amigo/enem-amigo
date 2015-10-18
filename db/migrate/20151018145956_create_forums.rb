class CreateForums < ActiveRecord::Migration
	def change
		create_table :forums do |t|
			t.string :name
			t.text :description
		end
	end
end