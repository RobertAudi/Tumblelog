# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  username        :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  auth_token      :string(255)
#  admin           :integer
#

require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :username => "user",
      :email => "user@example.com",
      :password => "password",
      :password_confirmation => "password",
      :admin => 0
    }
  end

  it "can generate auth tokens" do
    User.method_defined?(:generate_token).should be_true
  end

  describe "Validations" do
    describe "name" do
      it "should require a name" do
        user = User.new(@attr.merge(:username => nil))
        user.should_not be_valid
      end

      it "should reject usernames that are too short" do
        user = User.new(@attr.merge(:username => "XX"))
        user.should_not be_valid
      end

      it "should reject usernames that are too long" do
        user = User.new(@attr.merge(:username => "X" * 41))
        user.should_not be_valid
      end

      it "should accept valid usernames" do
        usernames = %w[AzizLight aziz_light azizlight42]
        usernames.each do |username|
          user = User.new(@attr.merge(:username => username))
          user.should be_valid
        end
      end

      it "should reject usernames that contain invalid characters" do
        user = User.new(@attr.merge(:username => "!@#\$%^&*()_-+=|\~`{}[]\"'/?><.,;:"))
        user.should_not be_valid
      end

      it "should reject usernames that are already in use" do
        User.create!(@attr)
        user = User.new(@attr)
        user.should_not be_valid
      end

      it "should reject usernames that are already in use (case-insensitive)" do
        User.create!(@attr.merge(:username => @attr[:username].upcase))
        user = User.new(@attr)
        user.should_not be_valid
      end
    end

    describe "email" do
      it "should require an email" do
        user = User.new(@attr.merge(:email => nil))
        user.should_not be_valid
      end

      it "should reject emails that are too short" do
        user = User.new(@attr.merge(:email => "X" * 7))
        user.should_not be_valid
      end

      it "should reject emails that are too long" do
        user = User.new(@attr.merge(:email => "X" * 256))
        user.should_not be_valid
      end

      it "should accept valid email addresses" do
        emails = %w[user@foo.com super-user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
        emails.each do |email|
          user = User.new(@attr.merge(:email => email))
          user.should be_valid
        end
      end

      it "should reject invalid emails" do
        emails = %w[user@foo,com THE_USER_foo.bar.org first.last@foo.]
        emails.each do |email|
          user = User.new(@attr.merge(:email => email))
          user.should_not be_valid
        end
      end

      it "should reject emails that are already in use" do
        User.create!(@attr)
        user = User.new(@attr)
        user.should_not be_valid
      end

      it "should reject emails that are already in use (case-insensitive)" do
        User.create!(@attr.merge(:email => @attr[:email].upcase))
        user = User.new(@attr)
        user.should_not be_valid
      end
    end

    describe "password" do
      it "should require a password" do
        user = User.new(@attr.merge(:password => ""))
        user.should_not be_valid
      end

      it "should require a matching password confirmation" do
        user = User.new(@attr.merge(:password_confirmation => "invalid"))
        user.should_not be_valid
      end

      it "should reject passwords that are too short" do
        password = "X" * 3
        user = User.new(@attr.merge(:password => password, :password_confirmation => password))
        user.should_not be_valid
      end

      it "should reject passwords that are too long" do
        password = "X" * 256
        user = User.new(@attr.merge(:password => password, :password_confirmation => password))
        user.should_not be_valid
      end
    end

    describe "admin" do
      it "should require a value for admin" do
        user = User.new(@attr.merge(:admin => nil))
        user.should_not be_valid
      end
    end
  end
end
