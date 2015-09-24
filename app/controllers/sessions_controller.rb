class SessionsController < ApplicationController
      def  new
      end

      def   create
            user  =   User.find_by(email:     params[:session][:email].downcase)
            if    user  &&    user.authenticate(params[:session][:password])
                  flash[:sucess] = 'Sucessfully logged!'
                  redirect_to signup_path
            else
                  flash[:danger]    =     'Invalid    email/password    combination'
                  render      'new'
            end
      end

      def destroy
      end

end