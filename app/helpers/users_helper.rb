module UsersHelper

  def top10
    ranking = User.all.order(:points).reverse
    @top10 = ranking.take(10)
  end

  #returns level of user without updating it
  def find_level user_points
    @user_level = (Math.sqrt 2*user_points).to_i
  end

  #update user level
  def update_user_level
    current_user.update_attribute(:level,@user_level)
    @user_level = current_user.level
  end
  
end