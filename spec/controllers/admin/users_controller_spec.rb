require 'spec_helper'

describe Admin::UsersController do
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
      response.should have_selector('title', :content => "Adding a new user...")
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @user = Factory(:user)
      get 'show', :id => @user
    end

    it "should be successful" do
      response.should be_success
    end

    it "should render the 'show' template" do
      response.should render_template('show')
    end

    it "should have the right title" do
      response.should have_selector('title', :content => @user.username)
    end

    it "should find the right user" do
      assigns[:user].should == @user
    end
  end

  describe "GET 'index'" do
    before(:each) do
      get 'index'
    end

    it "should be successful" do
      response.should be_success
    end

    it "should render the 'index' template" do
      response.should render_template('index')
    end

    it "should have the right title" do
      response.should have_selector('title', :content => "Home")
    end
  end

  describe "POST 'create'" do
    context "failure" do
      before(:each) do
        @attr = { :username => "", :email => "", :password => "", :password_confirmation => "" }
        post 'create', :user => @attr
      end

      it "should be successful" do
        response.should be_success
      end

      it "should re-render the signup form" do
        response.should render_template('new')
      end

      it "should have the right title" do
        response.should have_selector("title", :content => "Adding a new user...")
      end

      it "should not create a new user" do
        lambda do
          post 'create', :user => @attr
        end.should_not change(User, :count)
      end
    end

    context "success" do
      before(:each) do
        @attr = {
          :username => "ExampleUser",
          :email => "user@example.com",
          :password => "password",
          :password_confirmation => "password"
        }
      end

      it "should create a new user" do
        lambda do
          post 'create', :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the User show page" do
        post 'create', :user => @attr
        response.should redirect_to(admin_user_path(assigns[:user]))
      end
    end
  end
end
