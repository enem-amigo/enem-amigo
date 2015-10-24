class Medal < ActiveRecord::Base

  has_and_belongs_to_many :users

  serialize :achieved_instructions, Array
  serialize :message_instructions, Array

  validates :name, presence: true
  validates :description, presence: true
  validates :image, presence: true
  validates :achieved_instructions, presence: true
  validates :message_instructions, presence: true

  validate :instructions_work

  private

  def instructions_work
    current_user = User.create(name: "Joao", email: "joao@gmail.com", password: "12345678", nickname: "joaovitor")
    current_user.restore_attributes

    achieved_return = achieved?(current_user)
    errors.add(:achieved_instructions, "Changing user information") if current_user.changed?
    current_user.restore_attributes

    message_return = message(current_user)
    errors.add(:message_instructions, "Changing user information") if current_user.changed?

    instructions_return_valid_class(achieved_return, message_return)
  end

  def instructions_return_valid_class(achieved_return, message_return)
    if (achieved_return.class != TrueClass and achieved_return.class != FalseClass)
      errors.add(:achieved_instructions, "Achieved must be True or False")
    end

    if message_return.class != String
      errors.add(:message_instructions, "Message must be String")
    end
  end

  def achieved?(current_user)
    achieved_instructions.each do |instruction|
      eval instruction
    end

    rescue
      errors.add(:achieved_instructions, "Invalid instructions")
  end

  def message(current_user)
    message_instructions.each do |instruction|
      eval instruction
    end
    rescue
      errors.add(:message_instructions, "Invalid instructions")
  end

end