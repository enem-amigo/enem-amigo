class Exam < ActiveRecord::Base

  serialize :questions, Array
  validates :questions, presence: true

end