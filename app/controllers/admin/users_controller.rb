class Admin::UsersController < ApplicationController

  def index
    @title = "Home"
  end

  def show
    @user = User.find_by_id(params[:id])
    @title = "#{@user.username}"
  end

  def new
    @title = "Adding a new user..."
  end

end
