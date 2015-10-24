class CommentsController < ApplicationController

  before_action :authenticate_user
  before_action :authenticate_admin

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:sucess] = "Seu comentário foi criado com sucesso"
      redirect_to @comment
    else
      render 'form'
    end
  end

  def rate_comment
    comment = Comment.find(params[:id])

    if not comment.user_ratings.include? current_user.id
      comment.user_ratings.push(current_user.id)
      comment.save
    else
      redirect_to :back
    end

    respond_to do |format|
      format.html { redirect_to questions_path }
      format.js { flash[:notice] = "Votou!!" }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "O comentário foi excluído com sucesso"
    redirect_to root_path
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end