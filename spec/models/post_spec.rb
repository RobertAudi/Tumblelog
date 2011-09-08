require 'spec_helper'

describe Post do
  before(:each) do
    @attr = {
      :title => "This is the title",
      :body  => "This is the body",
      :id => 1
    }
  end
  
  describe "Validations" do
    describe "title" do
      it "should require a title" do
        post = Post.new(@attr.merge(:title => ""))
        post.should_not be_valid
      end
      
      it "should reject titles that are too long" do
        post = Post.new(@attr.merge(:title => "X" * 256))
        post.should_not be_valid
      end
    end
    
    describe "body" do
      it "should require a body" do
        post = Post.new(@attr.merge(:body => ""))
        post.should_not be_valid
      end
    end
    
    describe "user_id" do
      it "should require a user_id" do
        post = Post.new(@attr.merge(:user_id => nil))
        post.should_not be_valid
      end
      
      it "should require a valid user_id" do
        post = Post.new(@attr.merge(:user_id => "forty two"))
        post.should_not be_valid
        post = Post.new(@attr.merge(:user_id => 0))
        post.should_not be_valid
        post = Post.new(@attr.merge(:user_id => -1))
        post.should_not be_valid
      end
    end
  end
end
