class User < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  
  
  attr_accessible :login, :email, :password, :password_confirmation
  acts_as_authentic do |config|
    config.crypted_password_field = :encrypted_password
  end
end
