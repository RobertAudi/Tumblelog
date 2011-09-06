class Admin::UsersController < ApplicationController

  def index
    @title = "Home"
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

end
