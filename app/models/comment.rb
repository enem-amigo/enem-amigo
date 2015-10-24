class Comment < ActiveRecord::Base
  belongs_to :topic
  serialize :user_ratings, Array

  def count_comment_rates
    self.user_ratings.count
  end
end