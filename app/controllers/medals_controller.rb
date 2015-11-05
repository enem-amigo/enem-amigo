class MedalsController < ApplicationController

  def index
    check_medals
    @missing_medals = @medals - current_user.medals
  end

end
