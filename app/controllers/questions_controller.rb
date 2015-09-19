class QuestionsController < ApplicationController

	def index
	end

	def new
		@question = Question.new
	end

	def create
		@question = Question.new(question_params)
		if @question.save
			flash[:success] = "Questão cadastrada com sucesso!"
		else
			render 'new'
		end
	end

	def edit
		@question = Question.find(params[:id])
	end

	def update
		@question = Question.find(params[:id])
		if @question.update_attributes(question_params)
			flash[:success] = "Questão atualizada com sucesso!"
		else
			render 'edit'
		end
	end

	def show
		@question = Question.find(params[:id])
	end

	def destroy
		@question = Question.find(params[:id])
		@question.destroy
		flash[:success] = "Questão deletada com sucesso!"
		render 'index'
	end

	private

	def question_params
		params.require(:question).permit(:year,:area,:number,:enunciation,:reference,:image)
	end

end