class Post < ActiveRecord::Base
	has_many :comments
	belongs_to :topic
	belongs_to :user
end