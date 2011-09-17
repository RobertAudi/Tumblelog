require 'spec_helper'

describe Admin::PostsController do
  render_views

  describe "access control" do
    it "should restrict the access to all actions" do
      get 'index'
      response.should redirect_to login_path
      get 'new', :post_type => "text"
      response.should redirect_to login_path

      post = Factory(:post)
      get 'edit', :id => post.id
      response.should redirect_to login_path
      get 'show', :id => post.id
      response.should redirect_to login_path
    end
  end

  describe "GET 'index'" do
    before(:each) do
      test_log_in(Factory(:user))
      get 'index'
    end

    it "should be successful" do
      response.should be_success
    end

    it "should render the 'index' template" do
      response.should render_template('index')
    end

    it "should have the right title" do
      response.should have_selector('title', :content => "Posts")
    end

    it "should list posts" do
      30.times do
        Factory(:post, :title => Factory.next(:title), :body => Factory.next(:body))
      end

      get 'index'

      Post.paginate(:page => 1, :per_page => 15).order("created_at DESC").each do |post|
        response.should have_selector("tr>td>a", :content => post.title, :href => edit_admin_post_path(post))
      end
    end
  end

  describe "GET 'new'" do
    before(:each) do
      test_log_in(Factory(:user))
      get 'new', :post_type => "text"
    end

    it "should be successful" do
      response.should be_success
    end

    it "should render the new template" do
      response.should render_template('new')
    end

    it "should have the right title" do
      response.should have_selector('title', :content => "Creating a new post...")
    end
  end

  describe "POST 'create'" do
    before(:each) do
      test_log_in(Factory(:user))
    end

    context "failure" do
      before(:each) do
        @attr = {
          :title => "",
          :body => "",
          :user_id => 1,
          :draft => nil,
          :post_type => "text",
        }
        post 'create', :post => @attr
      end

      it "should not create a new post" do
        lambda do
          post 'create', :post => @attr
        end.should_not change(Post, :count)
      end

      it "should re-render the 'new' page" do
        response.should render_template('new')
      end

      it "should have the right title" do
        response.should have_selector('title', :content => "Creating a new post...")
      end
    end

    context "success" do
      before(:each) do
        @attr = {
          :title => "This is the title",
          :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
          :user_id => 1,
          :draft => 0,
          :post_type => "text"
        }
        post 'create', :post => @attr
      end

      it "should create a new user" do
        lambda do
          post 'create', :post => @attr
        end.should change(Post, :count).by(1)
      end

      it "should redirect the user to the newly created post" do
        response.should redirect_to(admin_post_path(assigns[:post].id))
      end

      it "should set a flash message to tell the user that the post was successfully created" do
        flash[:success].should =~ /post created successfully/i
      end
    end
  end

  describe "GET 'show'" do
    before(:each) do
      test_log_in(Factory(:user))
      @post = Factory(:post)
      get 'show', :id => @post.id
    end

    it "should be successfull" do
      response.should be_success
    end

    it "should render the show template" do
      response.should render_template('show')
    end

    it "should have the right title" do
      response.should have_selector('title', :content => @post.title)
    end

    it "should find the right post" do
      assigns[:post].should == @post
    end

    it "should redirect to the index page with an error message if no post was found" do
      get 'show', :id => "invalid"
      response.should redirect_to admin_posts_path
      flash[:alert].should =~ /unable to find the requested post/i
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      test_log_in(Factory(:user))
      @post = Factory(:post)
      get 'edit', :id => @post.id
    end

    it "should be successfull" do
      response.should be_success
    end

    it "should render the 'edit' template" do
      response.should render_template('edit')
    end

    it "should have the right title" do
      response.should have_selector("title", :content => "Editing \"#{@post.title}\"...")
    end

    it "should get the right post" do
      assigns[:post].should == @post
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      test_log_in(Factory(:user))
      @post = Factory(:post)
    end

    context "failure" do
      before(:each) do
        @attr = {
          :title => "",
          :body => "",
          :post_type => "text"
        }
        put 'update', :id => @post.id, :post => @attr
      end

      it "should render the 'edit' template" do
        response.should render_template('edit')
      end

      it "should have the right title" do
        response.should have_selector("title", :content => "Editing \"#{@attr[:title]}\"...")
      end
    end

    context "success" do
      before(:each) do
        @attr = {
          :title => "This is the title",
          :body => "This is the body. Lorem ipsum big bada boom.",
          :post_type => "text"
        }
        put 'update', :id => @post.id, :post => @attr
      end

      it "should redirect the user to the newly edited post" do
        response.should redirect_to(admin_post_path(@post))
      end

      it "should notify the user that the post was successfully edited" do
        flash[:success].should =~ /post updated successfully/i
      end
    end
  end
end
