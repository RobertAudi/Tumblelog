class PostsController < ApplicationController
  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 15).where("draft" => 0).order("created_at DESC")
  end

  def show
    @post = Post.find_by_id(params[:id])
    redirect_to root_url, :alert => "Unable to find the requested post!" if @post.draft == 1
    @title = @post.title
  end

end
