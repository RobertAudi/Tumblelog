class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?, :redirect_to_target_or_default

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

  def logged_in?
    current_user
  end
  
  # Used as a before filter
  def login_required
    unless logged_in?
      session[:return_to] = request.url
      redirect_to login_path, :alert => "You must first log in or sign up before accessing this page."
    end
  end

  def redirect_to_target_or_default(default, *args)
    redirect_to(session[:return_to] || default, *args)
    session[:return_to] = nil
  end

end
