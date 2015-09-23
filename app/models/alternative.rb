class Alternative < ActiveRecord::Base

	belongs_to :question, autosave: true
	validates :letter, presence: true, length: { maximum: 1 }
	validates :description, presence: true

end