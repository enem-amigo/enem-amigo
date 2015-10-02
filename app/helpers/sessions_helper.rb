module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def authenticate_user
    redirect_to login_path unless logged_in?
  end

  def authenticate_admin
    redirect_to_back(root_path) unless current_user.role_admin?
  end

  def verify_user_permission
    user = User.find(params[:id])
    redirect_to_back(users_path) unless user.id == current_user.id or current_user.role_admin?
  end

  def redirect_to_back(default = root_path)
    if !request.env["HTTP_REFERER"].blank? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back
    else
      redirect_to default
    end
  end

end