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
#

class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation
  has_secure_password
  
  before_create { generate_token(:auth_token) }
  
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

  validates :password, :presence => true,
                       :length => { :within => 4..255 }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
end
