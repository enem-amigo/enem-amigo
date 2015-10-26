module UsersHelper

  def top10
    ranking = User.all.order(:points).reverse
    min = ranking.count < 10 ? ranking.count : 10
    @top10 = ranking.take(min)
  end

  #returns level of user without updating it
  def find_level user_points
    @levels = [20,50,100,250,500,850,1300,1850,2500,3200]
    lvl_index = 0
    @user_level = 1
    last_level = @levels[@levels.size() - 1]

    if user_points > last_level
      @user_level = @levels.size()
    else
      while user_points > @levels[lvl_index]
        lvl_index += 1
        @user_level += 1
      end
    end

    @user_level
  end

  #update user level
  def update_user_level
    current_user.update_attribute(:level,@user_level)
    @user_level = current_user.level
  end
  
end