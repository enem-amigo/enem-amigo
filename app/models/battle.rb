class Battle < ActiveRecord::Base

  has_and_belongs_to_many :questions
  has_many :notifications
  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, class_name: 'User'
  belongs_to :winner, class_name: 'User'

  serialize :player_1_answers, Array
  serialize :player_2_answers, Array

  validates :player_2, presence: true

  def generate_questions
    self.questions = self.category == "" ? Question.all.sample(10) : Question.where(area: self.category).sample(10)
  end

  def all_played?
    self.player_1_start and self.player_2_start
  end

end