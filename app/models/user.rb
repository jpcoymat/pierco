class User < ApplicationRecord

  validates	:username, length: {:within => 3..40}
  validates	:username, :first_name, :last_name, :email, :password, presence: true
  validates	:username, uniqueness: true
  
  belongs_to 	:company

  has_secure_password

  def full_name
    self.first_name + " " + self.last_name
  end

  



end
