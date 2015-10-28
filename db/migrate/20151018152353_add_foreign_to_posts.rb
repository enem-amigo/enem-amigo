class AddForeignToPosts < ActiveRecord::Migration
	def change
		add_column :posts, :topic_id, :integer
		add_column :posts, :user_id, :integer
	end
end