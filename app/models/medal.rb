class Medal < ActiveRecord::Base

  has_and_belongs_to_many :users

  serialize :achieved_instructions, Array
  serialize :percentage_instructions, Array

  #validates :name, presence: true
  #validates :description, presence: true
  #validates :image, presence: true
  #validates :achieved_instructions, presence: true
  #validates :percentage_instructions, presence: true

  validate :instructions_work

  private

  def instructions_work
    current_user = User.create(name: "Joao", email: "joao@gmail.com", password: "12345678", nickname: "joaovitor")
    current_user.restore_attributes

    achieved_return = achieved?(current_user)
    errors.add(:achieved_instructions, "Changing user information") if current_user.changed?
    current_user.restore_attributes

    percentage_return = percentage(current_user)
    errors.add(:percentage_instructions, "Changing user information") if current_user.changed?
  end

  def instructions_return_valid_class(achieved_return, percentage_return)
    if (achieved_return.class != TrueClass and achieved_return.class != FalseClass)
      errors.add(:achieved_instructions, "Achieved must be True or False")
    end

    if percentage_return.class != Float
      errors.add(:percentage_instructions, "Percentage must be Float")
    end
  end

  def achieved?(current_user)
    achieved_instructions.each do |instruction|
      eval instruction
    end

    rescue
      errors.add(:achieved_instructions, "Invalid instructions")
  end

  def percentage(current_user)
    percentage_instructions.each do |instruction|
      eval instruction
    end

    rescue
      errors.add(:percentage_instructions, "Invalid instructions")
  end

end