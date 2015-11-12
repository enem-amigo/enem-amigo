class Exam < ActiveRecord::Base

  serialize :questions, Array
  serialize :right_answers, Array
  serialize :user_answers, Array
  validates :questions, presence: true
  validates :right_answers, presence: true

end
