class MedalsController < ApplicationController

  def index
    check_medals
    @missing_medals = Medal.all - current_user.medals
  end

  private

  def medal_params
    params.require(:medal).permit(:name, :description, :image, :achieved_instructions, :percentage_instructions)
  end

end
