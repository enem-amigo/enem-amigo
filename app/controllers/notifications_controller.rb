class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications.reverse
  end

end
