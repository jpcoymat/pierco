class ProductPhoto < ApplicationRecord

  mount_uploader :product_photograph, ProductPhotographUploader

  belongs_to :product
  
  validates :product_id, :product_photograph, presence: true




end
