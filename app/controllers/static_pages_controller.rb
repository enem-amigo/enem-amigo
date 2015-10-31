class StaticPagesController < ApplicationController

  before_action :authenticate_user, only: [:home]

  def home
    check_medals
    find_level current_user.points
  end

  def about
  end

  def help
  end

  def server_error
    redirect_to_back(root_path) unless session[:exception]
    session.delete(:exception)
  end

end