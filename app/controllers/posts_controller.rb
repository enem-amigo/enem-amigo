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
			redirect_to @post
		end
	end

	def show
		@post = Post.find(params[:id])
	end

	def index
		@posts = Post.all
	end

	def user_name(user_id)
		user = User.where(id: user_id).name
	end

	private

	def post_params
		params.require(:post).permit(:content)
	end

end