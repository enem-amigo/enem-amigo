module UsersHelper

  def top10
    ranking = User.all.order(:points).reverse
    min = ranking.count < 10 ? ranking.count : 10
    @top10 = ranking.take(min)
  end

end