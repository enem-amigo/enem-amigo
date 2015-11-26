class Text < ActiveRecord::Base
  belongs_to :question
  serialize :paragraphs, Array
end
