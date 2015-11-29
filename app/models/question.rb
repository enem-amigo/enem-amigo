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

  has_many :texts

  validate do
    check_alternatives_number
  end

  has_many :alternatives
  has_and_belongs_to_many :battles
  accepts_nested_attributes_for :alternatives, allow_destroy: true

  ALTERNATIVES_COUNT = 5

  def hit_rate
    hit_rate = self.tries == 0 ? 0 : (100 * (self.hits.to_f / self.tries)).round(2)
  end

  def next_question
    question = Question.where(area: self.area).where("id > ?", id).first
    question ? question : Question.where(area: self.area).first
  end

  def users_hit_rate
    users_hit_rate = self.users_tries == 0 ? 0 :
          (100 * (self.users_hits.to_f / self.users_tries)).round(2)
  end

  def total_hit_rate
    total_hit_rate = (100 * (self.hits + self.users_hits.to_f) / (self.tries + self.users_tries)).round(2)
  end

  def data
    [
      {"name" => "Enem","data" => {"Enem" => self.hit_rate}},
      {"name" => "Usuários","data" => {"Usuários" => self.users_hit_rate}},
      {"name" => "Todos","data" => {"Todos" => self.total_hit_rate}}
    ]
  end

  class << self
    def method_missing method_name, *args
      method_name = method_name.to_s
      if method_name.slice! /_questions/
        cmp_hash = { "easy" => lambda { |hit_rate| hit_rate >= 75.0 },
                     "intermediate" => lambda { |hit_rate| hit_rate >= 30.0 && hit_rate < 75.0 },
                     "hard" => lambda { |hit_rate| hit_rate < 30.0 } }
        questions = Question.where area: args.first
        questions.select { |q| cmp_hash[method_name].call q.total_hit_rate }
      else
        super
      end
    end
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