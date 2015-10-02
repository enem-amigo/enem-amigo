module ApplicationHelper
  
  # Returns the full title depending on the current page
  def full_title page_title = ''
    base_title = 'Enem Amigo'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

end
