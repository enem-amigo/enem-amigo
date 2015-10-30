class PostsController < ApplicationController

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		@post.topic_id = session[:topic_id]
		if @post.save
			flash[:success] = "Post criado com sucesso"
			redirect_to Topic.find(session[:topic_id])
		else
			render 'new'
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(post_params)
			flash[:success] = "Seu post foi atualizado com sucesso"
			redirect_to Topic.find(session[:topic_id])
		else
			render 'edit'
		end
	end

	def destroy
    	@post = Post.find(params[:id])
    	@post.destroy
    	flash[:success] = "Post deletado com sucesso"
    	redirect_to Topic.find(session[:topic_id])
  	end

	private

	def post_params
		params.require(:post).permit(:content)
	end

end