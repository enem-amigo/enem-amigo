module UsersHelper

  def top10
    ranking = User.all.order(:points).reverse
    @top10 = ranking.take(10)
  end

end