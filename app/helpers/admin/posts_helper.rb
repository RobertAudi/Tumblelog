module Admin::PostsHelper
  def get_title(post)
    if post.post_type == "text"
      post.title
    elsif post.post_type == "image"
      "(no title)"
    elsif post.post_type == "quote"
      truncate(post.quote)
    elsif post.post_type == "link"
      truncate(post.link)
    elsif post.post_type == "audio"
      "(no title)"
    elsif post.post_type == "video"
      "(no title)"
    end
  end
end
