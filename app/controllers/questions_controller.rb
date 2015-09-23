class QuestionsController < ApplicationController

	def index
		@question = Question.all
	end

	def new
		@question = Question.new
	end

	def create
		@question = Question.new(question_params)
		if @question.save
			flash[:success] = "Questão cadastrada com sucesso!"
			index
			render 'index'
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
		redirect_to questions_path
	end

	private

	def question_params
		params.require(:question).permit(:year,:area,:number,:enunciation,:reference,:image,:alternatives_attributes => [:letter, :description])
	end

end