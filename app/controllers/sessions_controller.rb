class SessionsController < ApplicationController
  layout 'login'
  
  def new
    redirect_to dashboard_path if logged_in?
    @title = "Log in"
  end
  
  def create
    # NOTE: I don't need user to be an instance variable but it is on so that the test could pass.
    # The test uses assigns
    @user = User.find_by_username(params[:session][:login]) || User.find_by_email(params[:session][:login])
    if @user && @user.authenticate(params[:session][:password])
      if params[:session][:remember_me] == "1"
        cookies.permanent[:auth_token] = @user.auth_token
      else
        cookies[:auth_token] = @user.auth_token
      end

      flash[:success] = "Logged in successfully!"
      redirect_to_target_or_default dashboard_path
    else
      @title = "Log in"
      flash.now[:error] = "Invalid login/password combination"
      render 'new'
    end
  end
  
  def destroy
    cookies[:auth_token] = nil
    # TODO: change the path below to be `root_path`
    redirect_to login_path
  end
  
  

end
