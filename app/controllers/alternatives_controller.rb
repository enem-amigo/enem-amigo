class AlternativesController < ApplicationController

	def new
		@alternative = Alternative.new
	end

	def create
		@alternative = Alternative.new(alternative_params)
		if @alternative.save
			flash[:success] = "Alternativa criada com sucesso!"
		else
			render 'new'
		end
	end

	def edit
		@alternative = Alternative.find(params[:id])
	end

	def update
		@alternative = Alternative.find(params[:id])
		if @alternative.update_attributes(alternative_params)
			flash[:success] = "Alternativa atualizada com sucesso!"
		else
			render 'edit'
		end
	end

	def show
		@alternative = Alternative.find(params[:id])
	end

	def destroy
		@alternative = Alternative.find(params[:id])
		@alternative.destroy
		#flash[:success] = "Alternativa excluida com sucesso!"
		#render 'index'
	end

	private

	def alternative_params
		params.require(:alternative).permit(:letter,:description)
	end

end