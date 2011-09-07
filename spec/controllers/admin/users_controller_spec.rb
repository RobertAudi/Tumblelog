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

  describe "GET 'edit'" do
    before(:each) do
      @user = Factory(:user)
      get 'edit', :id => @user
    end
    
    it "should be successful" do
      response.should be_success
    end
    
    it "should render the 'edit' template" do
      response.should render_template('edit')
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => "Editing #{@user.username}...")
    end
    
    it "should not render a username field" do
      response.should_not have_selector('input', :id => 'user_username')
    end
    
    it "should not render an email field" do
      response.should_not have_selector('input', :id => 'user_email')
    end
    
    it "should get the right user" do
      assigns[:user].should == @user
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @user = Factory(:user)
    end
    
    context "failure" do
      before(:each) do
        @attr = {
          :password => "",
          :password_confirmation => ""
        }

        put 'update', :id => @user.id, :user => @attr
      end
      
      it "should render the 'edit' template" do
        response.should render_template('edit')
      end

      it "should have the right title" do
        response.should have_selector("title", :content => "Editing #{@user.username}...")
      end
    end
    
    context "success" do
      before(:each) do
        @attr = {
          :password => "password",
          :password_confirmation => "password"
        }

        put 'update', :id => @user.id, :user => @attr
      end
      
      it "should redirect the user to the user show page" do
        response.should redirect_to(admin_user_path(@user))
      end
      
      it "should notify the user that his info has changed" do
        flash[:success].should =~ /you have successfully updated your info!/i
      end
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
      response.should have_selector('title', :content => "Users")
    end
    
    it "should list users" do
      # Create 30 fake users
      30.times do
        Factory(:user, :username => Factory.next(:username), :email => Factory.next(:email))
      end
      
      # Here I use `get 'index'` once again because I create the users after
      # having visited the page the first time.
      get 'index'
      
      # Here I am testing two things at the same time (but that's not such a big deal):
      # - The presence of the username
      # - The presence and validity of the link
      User.paginate(:page => 1).order("username ASC").each do |user|
        response.should have_selector("tr>td>a", :content => "#{user.username}",
                                                 :href => edit_admin_user_path(user))
      end
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
