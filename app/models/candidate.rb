class Candidate < ActiveRecord::Base
  validates :general_average, presence: true
end
