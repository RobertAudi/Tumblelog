module ApplicationHelper
  def title
    base_title = "Tumblelog"
    if @title.blank?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def format_date(date, include_time = false)
    time = include_time ? " at %I:%M %p" : ""
    date.strftime("%B #{date.day.ordinalize}, %Y#{time}")
  end

  def format_date(date, format = "long", include_time = false)
    if format == "long"
      time = include_time ? " at %I:%M %p" : ""
      date.strftime("%B #{date.day.ordinalize}, %Y#{time}")
    elsif format == "short"
      time = include_time ? " %I:%M %p" : ""
      date.strftime("%D#{time}")
    else
      
    end
  end

end
