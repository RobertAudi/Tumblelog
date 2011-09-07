class Admin::UsersController < ApplicationController

  def index
    @title = "Users"
    @users = User.paginate(:page => params[:page]).order("username ASC")
  end

  def show
    @user = User.find_by_id(params[:id])
    @title = @user.username
  end

  def new
    @title = "Adding a new user..."
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Successfully created a new user!"
      redirect_to admin_user_path(@user)
    else
      @title = "Adding a new user..."
      render 'new'
    end
  end
  
  def edit
    @user = User.find_by_id(params[:id])
    @title = "Editing #{@user.username}..."
  end
  
  def update
    @user = User.find_by_id(params[:id])
    
    # NOTE: The first two conditions make sure that a malicious user (or any other user)
    #       won't try to change his username or email
    if !params[:user].include?(:username) && !params[:user].include?(:email) && @user.update_attributes(params[:user])
      flash[:success] = "You have successfully updated your info!"
      redirect_to admin_user_path(@user)
    else
      @title = "Editing #{@user.username}..."
      render 'edit'
    end
    
  end
  

end
