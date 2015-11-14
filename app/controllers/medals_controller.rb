class MedalsController < ApplicationController

  before_action :authenticate_user

  def index
    check_medals
    @missing_medals = @medals - current_user.medals
  end

end
