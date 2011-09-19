# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  draft      :integer
#  post_type  :string(255)
#  image      :string(255)
#

class Post < ActiveRecord::Base
  attr_accessible :title, :body, :user_id, :draft, :post_type, :image
  
  belongs_to :user
  
  mount_uploader :image, ImageUploader

  with_options :if => :text_post_type? do |post|
    post.validates :title, :presence => true,
              :length => { :within => 1..255 }
    post.validates :body, :presence => true
  end

  with_options :if => :image_post_type? do |post|
    post.validates :image, :presence => true
  end

  validates :user_id, :presence => true,
                      :numericality => {
                                         :only_integer => true,
                                         :greater_than_or_equal_to => 1
                                       }

  validates :draft, :presence => true

  validates :post_type, :presence => true,
                        :format => { :with => /^(text|image|quote|link|audio|video)$/ }

  private

  def text_post_type?
    post_type == "text"
  end

  def image_post_type?
    post_type == "image"
  end
end
