class Question < ActiveRecord::Base

  before_save { self.area = area.mb_chars.downcase.to_s }
  before_save { self.right_answer = right_answer.downcase }

  validates :year, presence: true, length: { maximum: 4 }
  validates :area, presence: true
  validates :number, presence: true, length: { maximum: 3 }
  validates :enunciation, presence: true
  validates :alternatives, presence: true
  validates :right_answer, presence: true, length: { maximum: 1 }
  validates :number, uniqueness: { scope: [:year] }

  validate do
    check_alternatives_number
  end

  has_many :alternatives
  accepts_nested_attributes_for :alternatives, allow_destroy: true

  ALTERNATIVES_COUNT = 5

  def hit_rate
    (100 * (self.hits.to_f / self.tries)).round(2)
  end

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