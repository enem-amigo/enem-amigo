class Comment < ActiveRecord::Base
  serialize :user_ratings, Array
  validates :content, presence: true

  belongs_to :post
  belongs_to :user

  def count_comment_rates
    self.user_ratings.count
  end
end