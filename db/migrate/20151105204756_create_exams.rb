class CreateExams < ActiveRecord::Migration
	def change
		create_table :exams do |t|
			t.text :questions
		end
	end
end