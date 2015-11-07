class User < ActiveRecord::Base

  has_and_belongs_to_many :medals

  serialize :accepted_questions, Array
  serialize :answered_exams, Array

  before_save { self.email = email.downcase }
  has_secure_password
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length:{maximum: 60}
  validates :nickname, presence: true, length:{maximum: 40}, uniqueness: true
  validates :email, presence: true, length:{maximum: 255},
  format: { with:  VALID_EMAIL },
  uniqueness: { case_sensitive: false }
  validates :password, length:{minimum: 8}, presence: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Password.create(string, cost: cost)
  end

  def count_questions_by_area(area)
    i = 0
    self.accepted_questions.each do |t|
      if Question.find(t).area == area
        i = i+1
      end
    end
    i
  end

  def find_position_in_ranking
    ranking = User.all.order(:points).reverse
    for i in 0...ranking.count
      return i+1 if ranking[i].id == self.id
    end
  end

  def total_accepted_questions
    self.accepted_questions.count
  end

  def data
    [
      ["Matemática", self.count_questions_by_area('matemática e suas tecnologias')],
      ["Natureza", self.count_questions_by_area('ciências da natureza e suas tecnologias')],
      ["Linguagens", self.count_questions_by_area('linguagens, códigos e suas tecnologias')],
      ["Humanas", self.count_questions_by_area('ciências humanas e suas tecnologias')]
    ]
  end

  def progress
      (100 * self.total_accepted_questions.to_f/Question.all.count).round(2)
  end

end