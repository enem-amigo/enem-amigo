class CommentsController < ApplicationController

	before_action :authenticate_user
	before_action :authenticate_admin

	def new
		@comment = Comment.new
	end

	def create
		@comment = Comment.new(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			flash[:success] = "Seu comentário foi criado com sucesso"
			redirect_to Topic.find(session[:topic_id])
		else
			render 'form'
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:content, :post_id)
	end

end
