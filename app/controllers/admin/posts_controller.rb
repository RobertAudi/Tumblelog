class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 15).order("created_at DESC")
    @title = "Posts"
  end

  def new
    @post = Post.new
    @form_partial = get_form_partial(params[:post_type])
    redirect_to admin_posts_path, :alert => "You tried to create an unknown type of post..." if @form_partial.nil?
    @title = "Creating a new post..."
  end
  
  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:success] = "Post created successfully!"
      redirect_to admin_post_path(@post)
    else
      @title = "Creating a new post..."
      @form_partial = get_form_partial(params[:post][:post_type])
      render 'new'
    end
  end

  def show
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      # FIXME: Show 404 instead
      redirect_to admin_posts_path, :alert => "Unable to find the requested post..."
    else
      @title = @post.title
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
    redirect_to admin_post_path(@path), :alert => "You are not allowed to edit this post!" unless author?
    if @post.nil?
      # FIXME: Show 404 instead
      flash[:alert] = "Unable to find the requested post..."
      redirect_to admin_posts_path
    else
      @title = "Editing \"#{@post.title}\"..."
      @form_partial = get_form_partial(@post.post_type)
    end
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.update_attributes(params[:post])
      flash[:success] = "Post updated successfully!"
      redirect_to admin_post_path(@post)
    else
      @title = "Editing \"#{@post.title}\"..."
      @form_partial = get_form_partial(params[:post][:post_type])
      render 'edit'
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    if admin? && @post.destroy
      flash[:success] = "Post deleted successfully!"
      redirect_to admin_posts_path
    else
      redirect_to admin_posts_path, :alert => "You are not allowed to delete users!"
    end
  end

  private
  
  def author?
    admin? || current_user.id == @post.user_id
  end

  def get_form_partial(post_type)
    # Types logic
    if post_type == "text"
      "text_form"
    elsif post_type == "image"
      # NOTE: Not yet implemented
      nil
    elsif post_type == "quote"
      # NOTE: Not yet implemented
      nil
    elsif post_type == "link"
      # NOTE: Not yet implemented
      nil
    elsif post_type == "audio"
      # NOTE: Not yet implemented
      nil
    elsif post_type == "video"
      # NOTE: Not yet implemented
      nil
    else
      nil
    end

  end

  
end


