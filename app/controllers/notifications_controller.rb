class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications
  end

  private

    def notification_params
      params.require(:notification).permit(:message, :image, :user_sender, :user_receiver)
    end


end
