class Post < ActiveRecord::Base

	has_many :comments
	belongs_to :topic
  serialize :user_ratings, Array

  def count_rates
    self.user_ratings.count
  end

end