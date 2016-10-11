class Contact < ApplicationRecord
  
  validates :company_id, :message, :email, :name, presence: true
  
  belongs_to :company


end
