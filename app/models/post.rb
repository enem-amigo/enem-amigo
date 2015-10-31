class Post < ActiveRecord::Base

  has_many :comments
  belongs_to :topic

  serialize :user_ratings, Array
  validates :content, presence: true
  belongs_to :user

  def count_post_rates
    self.user_ratings.count
  end
end