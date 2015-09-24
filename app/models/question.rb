class Question < ActiveRecord::Base

	validates :year, presence: true, length: { maximum: 4 }
	validates :area, presence: true
	validates :number, presence: true, length: { maximum: 3 }
	validates :enunciation, presence: true
	validates :reference, presence: true

	has_many :alternatives
	accepts_nested_attributes_for :alternatives, allow_destroy: true

end