class MedalsController < ApplicationController

  def index
    check_medals
    @missing_medals = @medals - current_user.medals
  end

  private

  def medal_params
    params.require(:medal).permit(:name, :description, :image, :achieved_instructions, :percentage_instructions)
  end

end
