module MedalsHelper

  def check_medals
    @missing_medals = Medal.all - current_user.medals
    @missing_medals.each do |missing_medal|
      current_user.medals << missing_medal if achieved(missing_medal)
    end
  end

  def achieved(medal)
    medal.achieved_instructions.each do |instruction|
      eval instruction
    end
  end

  def percentage(medal)
    medal.percentage_instructions.each do |instruction|
      eval instruction
    end
  end

end