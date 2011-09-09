require 'spec_helper'

describe Admin::DashboardController do
  render_views

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
      response.should have_selector("title", :content => "Dashboard")
    end
    
    it "should list the five latest posts" do
      assigns[:posts].length.should <= 5
    end
  end

end
