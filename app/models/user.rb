class User < ActiveRecord::Base
  attr_accessible :login, :password, :password_confirmation
  acts_as_authentic do |config|
    config.crypted_password_field = :encrypted_password
  end
end
