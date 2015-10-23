module MedalsHelper

  def check_medals
    @medals = Medal.all
    @new_medals = []
    missing_medals = @medals - current_user.medals
    missing_medals.each do |missing_medal|
      if achieved(missing_medal)
        current_user.medals << missing_medal
        @new_medals.push(missing_medal)
      end
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