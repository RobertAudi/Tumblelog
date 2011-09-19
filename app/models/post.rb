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
#  quote      :string(255)
#

class Post < ActiveRecord::Base
  attr_accessible :title, :body, :user_id, :draft, :post_type
  
  belongs_to :user
  
  with_options :if => :text_post_type? do |post|
    post.validates :title, :presence => true,
              :length => { :within => 1..255 }
    post.validates :body, :presence => true
  end


  validates :user_id, :presence => true,
                      :numericality => {
                                         :only_integer => true,
                                         :greater_than_or_equal_to => 1
                                       }

  validates :draft, :presence => true

  validates :post_type, :presence => true,
                        :format => { :with => /^(text|image|quote|link|audio|video)$/ }

  def get_form_partial(post_type)
    # Types logic
    if post_type == "text"
      "text_form"
    elsif post_type == "image"
      # NOTE: Not yet implemented
      nil
    elsif post_type == "quote"
      # NOTE: Not yet implemented
      nil
    elsif post_type == "link"
      # NOTE: Not yet implemented
      nil
    elsif post_type == "audio"
      # NOTE: Not yet implemented
      nil
    elsif post_type == "video"
      # NOTE: Not yet implemented
      nil
    else
      nil
    end
  end

  private

  def text_post_type?
    post_type == "text"
  end
end
