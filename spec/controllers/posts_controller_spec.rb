require 'spec_helper'

describe PostsController do
  render_views

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

    it "should list posts" do
      Factory(:user)
      30.times do
        Factory(:post, :title => Factory.next(:title), :body => Factory.next(:body))
      end

      get 'index'

      Post.paginate(:page => 1, :per_page => 15).order("created_at DESC").each do |post|
        response.should have_selector("h2>a", :content => post.title, :href => post_path(post))
      end
    end

    it "should not display drafts" do
      Factory(:user)
      post = Factory(:post, :draft => 1)
      
      get 'index'

      response.should_not have_selector("h2", :content => post.title)
    end
  end

  describe "GET 'show'" do
    before(:each) do
      Factory(:user)
      @post = Factory(:post)
      get 'show', :id => @post.id
    end

    it "should be successful" do
      response.should be_success
    end

    it "should render the 'show' template" do
      response.should render_template('show')
    end

    it "should have the right title" do
      response.should have_selector("title", :content => @post.title)
    end

    it "should retrive the correct post" do
      assigns[:post].should == @post
    end

    context "draft" do
      before(:each) do
        post = Factory(:post, :draft => 1)
        get 'show', :id => post.id
      end
      
      it "should redirect the user to the root path" do
        response.should redirect_to(root_path)
      end

      it "should show a message informing the user that the post doesn't exist" do
        flash[:alert].should =~ /unable to find the requested post/i
      end
    end
  end

end
