class PostsController < ApplicationController

  before_action :authenticate_user
  before_action :verify_user_permission, only: [:destroy, :edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.topic_id = session[:topic_id]
    if @post.save
      flash[:success] = "Postagem criada com sucesso"
      redirect_to Topic.find(session[:topic_id])
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:post_id])
  end

  def update
    @post = Post.find(params[:post_id])
    if @post.update_attributes(post_params)
      flash[:success] = "Seu post foi atualizado com sucesso"
      redirect_to Topic.find(session[:topic_id])
    else
      render 'edit'
    end
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
    @post = Post.find(params[:post_id])
    @post.destroy
    flash[:success] = "Post deletado com sucesso"
    redirect_to Topic.find(session[:topic_id])
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end