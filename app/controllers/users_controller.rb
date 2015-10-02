class UsersController < ApplicationController

  before_action :authenticate_user, except: [:ranking, :new, :create]
  before_action :verify_user_permission, only: [:edit, :destroy]

  def new
    @home_page = true
    @user = User.new
    redirect_to current_user if logged_in?
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "Usuário foi deletado"
    redirect_to users_path
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Usuário criado com sucesso!"
      log_in @user
      redirect_to @user
    else
      flash.now[:danger] = "Não foi possível criar seu usuário"
      render 'new'
    end
  end

  def update
    @user= User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success]= "Usuário atualizado"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users= User.all
  end

  def ranking
    @users = User.order(:points).reverse
  end

  def top10
    ranking = User.all.order(:points).reverse
    min = ranking.count < 10 ? ranking.count : 10
    @top10 = ranking.take(min)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :level, :points, :nickname, :password_digest,:password, :password_confirmation)
  end

end
