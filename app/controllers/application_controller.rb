class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  include SessionsHelper
  if ENV['RAILS_ENV'] != 'test'
    rescue_from Exception, :with => :server_exception
    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
    rescue_from ActionController::RoutingError, :with => :raise_not_found!

    def server_exception
      redirect_to server_error_path
      flash.now[:danger] = "Ocorreu um erro no servidor"
      session[:exception] = "exception"
    end

    def raise_not_found!
      redirect_to_back(root_path)
      flash[:danger] = "Página não encontrada"
    end

    def record_not_found
      redirect_to_back(root_path)
      resource = request.url[/(\/\w+\/)/, 0]
      resource.slice!(0)
      resource.slice!(resource.length-1)

      flash[:danger] = "#{resource.singularize == 'question' ? 'Questão não encontrada' : 'Usuário não encontrado'}"
    end
  end

end
