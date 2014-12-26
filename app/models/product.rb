class Product < ActiveRecord::Base

  mount_uploader :product_picture, ProductPictureUploader 

  validates :name,  :supplier_id, :product_category_id, :product_subcategory_id, presence: true
  validates :name,  :uniqueness => true  
  
  belongs_to  :supplier
  belongs_to  :product_category
  belongs_to  :product_subcategory
  has_many    :product_dimensions, dependent: :destroy


end
