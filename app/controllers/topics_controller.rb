class TopicsController < ApplicationController

	include PostsHelper
	include CommentsHelper

	before_action :authenticate_user
  	before_action :authenticate_admin, only: [ :new, :create, :edit, :destroy, :update ]

	def new
		@topic = Topic.new
	end

	def create
		@topic = Topic.new(topic_params)
		if @topic.save
			flash[:success] = "Tópico criado com sucesso"
			redirect_to @topic
		end
	end

	def show
		@topic = Topic.find(params[:id])
		session[:topic_id] = @topic.id
		new_post
	end

	def index
		@topics = Topic.all
	end

	private

	def topic_params
		params.require(:topic).permit(:name, :description)
	end

end