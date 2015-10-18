class TopicsController < ApplicationController

	def new
		@topic = Topic.new
	end

	def create
		@topic = Topic.new(topic_params)
		if @topic.save
			flash[:sucess] = "O tópico foi criado com sucesso"
			redirect_to @topic
		else
			render 'form'
		end
	end

	def show
		@topic = Topic.find(params[:id])
	end

	private

	def topic_params
		params.require(:topic).permit(:name, :question_id, :last_update_at)
	end
end