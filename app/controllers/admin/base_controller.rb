class Admin::BaseController < ApplicationController
  layout 'admin'
  
  before_filter :login_required
  
  def admin_required
    unless admin?
      redirect_to root_url, :alert => "You need to be an Administrator to access this page."
    end
  end

  private
  
  def login_required
    unless logged_in?
      session[:return_to] = request.url
      redirect_to login_path, :alert => "You must first log in or sign up before accessing this page."
    end
  end
end
