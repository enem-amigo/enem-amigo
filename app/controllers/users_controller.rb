class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def edit
    @user= User.find(params[:id])
  end

  def delete
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User was deleted"
    redirect_to users_path
  end

  def show
    @user= User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.level = 0
    @user.points = 0

    if @user.save
      flash[:success]= "User was created"
      redirect_to @user
    else
      render 'new'
      flash[:failure]= "It was not possible to create your user"
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
    params.require(:user).permit(:name, :email, :level, :nickname, :password_digest,:password, :password_confirmation)
  end

end
