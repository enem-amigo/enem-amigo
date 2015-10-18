class PostsController < ApplicationController

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		if @post.save
			flash[:sucess] = "Seu comentário foi criado com sucesso"
			redirect_to @topic
		else
			render 'form'
		end
	end

	private

	def post_params
		params.require(:post).permit(:content)
	end

end