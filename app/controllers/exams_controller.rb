class ExamsController < ApplicationController

	def new
		@exam = Exam.new
		math_questions = Question.where(area: "matemática e suas tecnologias")
		humans_questions = Question.where(area: "ciências humanas e suas tecnologias")
		language_questions = Question.where(area: "linguagens, códigos e suas tecnologias")
		nature_questions = Question.where(area: "ciências da natureza e suas tecnologias")
		
		@exam.questions.push((1..humans_questions.count).to_a.sample 22)
		@exam.questions.push((1..math_questions.count).to_a.sample 23)
		@exam.questions.push((1..language_questions.count).to_a.sample 23)
		@exam.questions.push((1..nature_questions.count).to_a.sample 23)
	end

	def create
		@exam = Exam.new(exam_params)
		if @exam.save
			flash[:sucess] = "Prova criada com sucesso"
		else 
			flash[:danger] = "Algo errado ocorreu"
	end
	
	private
	
	def exam_params
		params.require(:exams).permit(:questions)
	end
end