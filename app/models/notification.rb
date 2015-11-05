class Notification < ActiveRecord::Base

  belongs_to :user_sender, :class_name => 'User'
  belongs_to :user_receiver, :class_name => 'User'

  validates :message, presence: true
  validates :image, presence: true

end