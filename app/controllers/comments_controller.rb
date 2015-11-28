class CommentsController < ApplicationController

  before_action :authenticate_user
  before_action :verify_user_permission, only: [:destroy, :edit]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = params[:post_id]
    if @comment.save
      flash[:success] = "Seu comentário foi criado com sucesso"
      redirect_to Topic.find(session[:topic_id])
    else
      redirect_to new_post_comment_path(params[:post_id])
    end
  end

  def edit
    @comment = Comment.find(params[:comment_id])
  end

  def update
    @comment = Comment.find(params[:comment_id])
    if @comment.update_attributes(comment_params)
      flash[:success] = "Seu comentário foi atualizado com sucesso"
      redirect_to Topic.find(session[:topic_id])
    else
      redirect_to edit_post_comment_path(session[:topic_id])
    end
  end

  def rate_comment
    comment = Comment.find(params[:comment_id])

    if not comment.user_ratings.include? current_user.id
      comment.user_ratings.push(current_user.id)
      comment.save
    else
      redirect_to_back(root_path)
    end

    respond_to do |format|
      format.html { redirect_to_back(root_path) }
      format.js { flash[:notice] = "Votou!!" }
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    flash[:success] = "Comentário deletado com sucesso"
    redirect_to Topic.find(session[:topic_id])
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end