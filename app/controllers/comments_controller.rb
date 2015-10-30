class CommentsController < ApplicationController

	def new
		@comment = Comment.new
	end

	def create
		@comment = Comment.new(comment_params)
		@comment.user_id = current_user.id
		@comment.post_id = session[:post_id]
		if @comment.save
			flash[:success] = "Seu comentário foi criado com sucesso"
			redirect_to Topic.find(session[:topic_id])
		else
			redirect_to new_post_comment_path(session[:post_id])
		end
	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def update
		@comment = Comment.find(params[:id])
		if @comment.update_attributes(post_params)
			flash[:success] = "Seu comentário foi atualizado com sucesso"
			redirect_to Topic.find(session[:topic_id])
		else
			redirect_to edit_post_comment_path(session[:post_id])
		end
	end

	def destroy
    	@comment = Comment.find(params[:id])
    	@comment.destroy
    	flash[:success] = "Comentário deletado com sucesso"
    	redirect_to Topic.find(session[:topic_id])
  	end

	private

	def comment_params
		params.permit(:content)
	end

end
