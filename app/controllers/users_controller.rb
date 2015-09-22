class UsersController < ApplicationController
      def index
            @users = User.all
      end
      def new
             @users = User.new
      end

      def edit
      end

      def destroy
      end

      def show
      end
end