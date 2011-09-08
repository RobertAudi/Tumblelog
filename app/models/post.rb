# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  
  validates :title, :presence => true,
                    :length => { :within => 1..255 }

  validates :body, :presence => true
end
