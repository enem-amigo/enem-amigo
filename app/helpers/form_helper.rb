module FormHelper

	def setup_question(question)
		5.times { question.alternatives.build }
		question
	end

end