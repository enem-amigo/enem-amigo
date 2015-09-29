class User < ActiveRecord::Base

  serialize :accepted_questions, Array

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

  def find_by_area(area)
    i = 0
    self.accepted_questions.each do |t|
      if Question.find(t).area == area
        i = i+1
      end
    end
    i
  end

  def is_admin?
    self.role_admin
  end

end