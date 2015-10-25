class Topic < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	validates :description, presence: true, uniqueness: true

	has_many :posts
end