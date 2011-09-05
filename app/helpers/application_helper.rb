module ApplicationHelper
  def title
    base_title = "Tumblelog"
    if @title.blank?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
end
