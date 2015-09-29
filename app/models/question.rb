class Question < ActiveRecord::Base

  validates :year, presence: true, length: { maximum: 4 }
  validates :area, presence: true
  validates :number, presence: true, length: { maximum: 3 }
  validates :enunciation, presence: true
  validates :alternatives, presence: true
  validates :right_answer, presence: true, length: { maximum: 1 }

  validate do
    check_alternatives_number
  end

  has_many :alternatives
  accepts_nested_attributes_for :alternatives, allow_destroy: true

  ALTERNATIVES_COUNT = 5

  private

    def alternatives_count_valid?
      self.alternatives.size == ALTERNATIVES_COUNT
    end

    def check_alternatives_number
      unless alternatives_count_valid?
        errors.add(:alternatives, "cannot be less than 5")
      end
    end

end