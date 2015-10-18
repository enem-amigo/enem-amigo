class ForumsController < ApplicationController

	def new
		@forum = Forum.new
	end

	def create
		@forum = Forum.new(forum_params)
		if @forum.save
			flash[:sucess] = "Fórum criado com sucesso"
			redirect_to @forum
		end
	end

	def show
		@forum = Forum.find(params[:id])
	end

	def index
		@forums = Forum.all
	end

	private

	def forum_params
		params.require(:forum).permit(:name, :description)
	end

end