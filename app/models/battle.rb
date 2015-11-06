class Battle < ActiveRecord::Base

  has_many :questions
  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, class_name: 'User'

  serialize :player_1_answers, Array
  serialize :player_2_answers, Array

  validates :answer, presence: true
end