class Alternative < ActiveRecord::Base

	belongs_to :question
	validates :letter, length: { maximum: 1 }
	validates_presence_of :letter
	validates_presence_of :description

end