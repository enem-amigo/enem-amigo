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
    find_level current_user.points
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Usuário criado com sucesso!"
      log_in @user
      first_notification
      redirect_to root_path
    else
      @home_page = true
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success]= "Usuário atualizado"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.all
  end

  def ranking
    @home_page = true unless logged_in?
    @users = User.order(:points).reverse
  end

  def delete_profile_image
    unless current_user.profile_image_file_name.empty?
      current_user.update_attribute(:profile_image_file_name,"")
      flash[:success] = "Foto de perfil removida com sucesso!"
    else
      flash[:danger] = "Não há foto de perfil para ser removida."
    end
    redirect_to user_path(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :level, :points, :nickname, :password_digest,:password, :password_confirmation, :profile_image)
  end

end
