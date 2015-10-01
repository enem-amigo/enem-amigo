class UsersController < ApplicationController

  before_action :authenticate_user, except: [:ranking, :new, :create]

  def new
    @user = User.new
    redirect_to current_user if logged_in?
  end

  def edit
    @user = User.find(params[:id])
    redirect_to users_path unless @user.id == current_user.id or current_user.is_admin?
  end

  def destroy
    @user = User.find(params[:id])
    if @user.id == current_user.id or current_user.is_admin?
      @user.destroy
      flash[:notice] = "Usuário foi deletado"
      redirect_to users_path
    else
      redirect_to :back
    end
  end

  def show
    @user= User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Usuário criado com sucesso!"
      log_in @user
      redirect_to @user
    else
      flash[:failure] = "Não foi possível criar seu usuário"
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :level, :points, :nickname, :password_digest,:password, :password_confirmation)
  end

end
