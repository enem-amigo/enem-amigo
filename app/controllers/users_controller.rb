class UsersController < ApplicationController

  before_action :authenticate_user, except: [:ranking, :new]

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    redirect_to users_path unless @user.id == current_user.id or current_user.is_admin?
  end

  def destroy
    @user = User.find(params[:id])
    if @user.id == current_user.id or current_user.is_admin?
      @user.destroy
      flash[:notice] = "User was deleted"
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
    @user.level = 1
    @user.points = 0
    @user.role_admin = false

    if @user.save
      flash[:success] = "User was created"
      redirect_to @user
    else
      render 'new'
      flash[:failure] = "It was not possible to create your user"
    end
  end

  def update
    @user= User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success]= "User was updated"
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
