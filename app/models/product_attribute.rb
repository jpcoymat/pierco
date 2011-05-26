class ProductAttribute < ActiveRecord::Base

  belongs_to :product
  validates :product_id, :product_attribute, :presence => true
  

end
