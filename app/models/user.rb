class User < ActiveRecord::Base
  validates	:username, length: {:within => 3..40}
  validates	:username, :first_name, :last_name, :email, :hashed_password, presence: true
  validates	:username, uniqueness: true

  validates	:password, confirmation: true

  validate 	:password_must_be_present

  attr_accessor	:password, :password_confirmation
  
  belongs_to 	:company


  def full_name
    self.first_name + " " + self.last_name
  end

  def password_must_be_present
    errors.add(:password, "Missing password" ) unless hashed_password.present?
  end

  def self.sex
    ["Male", "Female"]
  end
  
  def self.authenticate(username, password)
    user = User.where(username: username).first
    unless user.nil?
      expected_password = Digest::SHA1.hexdigest(password)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user 
  end

  def password
    @password
  end
  
  
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    self.hashed_password = Digest::SHA1.hexdigest(self.password)
  end



end
