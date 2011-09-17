class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 15).order("created_at DESC")
    @title = "Posts"
  end

  def new
    @post = Post.new
    @title = "Creating a new post..."
  end
  
  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:success] = "Post created successfully!"
      redirect_to admin_post_path(@post)
    else
      @title = "Creating a new post..."
      render 'new'
    end
  end

  def show
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      # FIXME: Show 404 instead
      flash[:error] = "Unable to find the requested post..."
      redirect_to :action => :index
    else
      @title = @post.title
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
    redirect_to admin_post_path(@path), :alert => "You are not allowed to edit this post!" unless author?
    if @post.nil?
      # FIXME: Show 404 instead
      flash[:error] = "Unable to find the requested post..."
      redirect_to :action => :index
    else
      @title = "Editing \"#{@post.title}\"..."
    end
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.update_attributes(params[:post])
      flash[:success] = "Post updated successfully!"
      redirect_to admin_post_path(@post)
    else
      @title = "Editing \"#{@post.title}\"..."
      render 'edit'
    end
  end
  
  private
  
  def author?
    admin? || current_user.id == @post.user_id
  end
end
