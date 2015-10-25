class Post < ActiveRecord::Base
	validates :content, presence: true


	has_many :comments
	belongs_to :topic
	belongs_to :user
end