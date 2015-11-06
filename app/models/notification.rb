class Notification < ActiveRecord::Base

  belongs_to :battle

  validates :message, presence: true

end