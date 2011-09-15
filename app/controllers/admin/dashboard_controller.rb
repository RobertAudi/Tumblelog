class Admin::DashboardController < Admin::BaseController
  def index
    @title = "Dashboard"
    @posts = Post.where("draft" => 0).order("created_at DESC").limit(5)
    @drafts = Post.where("draft" => 1).order("created_at DESC").limit(5)
  end
end
