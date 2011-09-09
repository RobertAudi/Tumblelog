class PostsController < ApplicationController
  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 15).order("created_at DESC")
  end

  def show
    @post = Post.find_by_id(params[:id])
    @title = @post.title
  end

end
