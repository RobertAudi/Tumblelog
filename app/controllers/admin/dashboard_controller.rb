class Admin::DashboardController < Admin::BaseController
  def index
    @title = "Dashboard"
    @posts = Post.order("created_at DESC").limit(5)
  end
end
