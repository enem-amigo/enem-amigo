class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  include SessionsHelper

  rescue_from Exception, :with => :raise_not_found!
  rescue_from ActiveRecord::RecordNotFound, :with => :raise_not_found!
  rescue_from ActionController::RoutingError, :with => :raise_not_found!

  def raise_not_found!
    redirect_to_back(root_path)
    flash[:danger] = "Página não encontrada"
  end

end
