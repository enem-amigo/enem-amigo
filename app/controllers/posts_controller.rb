class PostsController < ApplicationController

  before_action :authenticate_user
  before_action :verify_user_permission, only: [:destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.topic_id = session[:topic_id]
    if @post.save
      flash[:success] = "Postagem criada com sucesso"
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

  def rate_post
    post = Post.find(params[:id])

    if not post.user_ratings.include? current_user.id
      post.user_ratings.push(current_user.id)
      post.save
    else
      redirect_to_back(root_path)
    end

    respond_to do |format|
      format.html { redirect_to_back(root_path) }
      format.js { flash[:notice] = "Votou!!" }
    end
  end

  def destroy
    @post = Post.find(params[:id])
    post_parent = @post.topic_id
    @post.destroy
    flash[:notice] = "A postagem foi excluída com sucesso"
    redirect_to topic_path(post_parent)
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end