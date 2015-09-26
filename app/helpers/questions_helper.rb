module QuestionsHelper

  def category=(category)
    session[:category] = category
  end

  def current_category
    session[:category]
  end

  def category_selected?
    !!current_category
  end

end