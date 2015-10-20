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

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		flash[:notice] = "O comentário foi excluído com sucesso"
		redirect_to @topic
	end

	def rate
		post = Post.find(params[:id])
		unless current_user.rating.include? post.id
			current_user.rating.push(post.id)
		end
		redirect_to questions_path
	end
		
	private

	def post_params
		params.require(:post).permit(:content)
	end

end