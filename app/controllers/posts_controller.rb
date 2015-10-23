class PostsController < ApplicationController

	before_action :authenticate_user
	before_action :authenticate_admin

		def new
			@post = Post.new
		end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		@post.topic_id = session[:topic_id]
		if @post.save
			flash[:success] = "Comentário criado com sucesso"
			redirect_to Topic.find(session[:topic_id])
		end
	end

	private

	def post_params
		params.require(:post).permit(:content)
	end

end