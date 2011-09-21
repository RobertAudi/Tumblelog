require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do
    before(:each) do
      get 'new'
    end

    it "should be successful" do
      response.should be_success
    end

    it "should render the 'new' template" do
      response.should render_template('new')
    end

    it "should have the right title" do
      response.should have_selector('title', :content => "Log in")
    end
  end

  describe "POST 'create'" do
    context "failure" do
      before(:each) do
        post 'create', :session => { :username_or_email => "", :password => "" }
      end

      it "should re-render the log in page" do
        response.should render_template('new')
      end

      it "should have the right title" do
        response.should have_selector('title', :content => "Log in")
      end

      it "should display an error message to the user" do
        flash.now[:alert].should =~ /invalid/i
      end
    end

    context "success" do
      before(:each) do
        @user = Factory(:user)
        post 'create', :session => { :login => @user.username, :password => @user.password, :remember_me => "0" }
      end

      it "should redirect the user to the dashboard" do
        response.should redirect_to(dashboard_path)
      end

      it "should retrieve the correct user" do
        assigns[:user].should == @user
      end

      it "should retrieve the correct user even if the user logged in with his email" do
        post 'create', :session => { :login => @user.email, :password => @user.password }
        assigns[:user].should == @user
      end

      it "should log in the user" do
        controller.current_user.should == @user
        cookies[:auth_token].should == @user.auth_token
        controller.should be_logged_in
      end
    end
  end

  describe "DELETE 'destroy'" do
    it "should log the user out" do
      test_log_in(Factory(:user))
      delete 'destroy'

      response.cookies[:auth_token].should be_nil
      controller.should_not be_logged_in
      controller.current_user.should be_nil

      response.should redirect_to(root_path)
    end
  end
end
