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
#

class User < ActiveRecord::Base
  has_secure_password
  
  # Validations
  validates :username, :presence => true,
                       :uniqueness => { :case_sensitive => false },
                       :length => { :within => 3..40 },
                       :format => { :with => /^[\w_]+$/i, 
                                    :message => "should only contain letters, numbers, or underscores" }

  validates :email, :presence => true,
                     :uniqueness => { :case_sensitive => false },
                     :length => { :within => 8..255 },
                     :format => { :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i }

  validates :password, :length => { :within => 4..255 }
end
