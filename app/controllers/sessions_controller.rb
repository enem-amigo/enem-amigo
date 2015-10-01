class SessionsController < ApplicationController
  def new
    @home_page = true # FIXME
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
       flash[:success] = "Logado com sucesso!"
      else
       flash.now[:danger] = 'Combinação inválida de e-mail/senha'
      render 'new'
    end
  end

  def destroy
    if current_user
      log_out
    end
    redirect_to login_path
  end

end