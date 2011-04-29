class ProductSubcategory < ActiveRecord::Base

  belongs_to :product_category
  has_many   :products
  
  validates :product_category_id, :name, :description, :presence => true
  validates :name, :uniqueness => true
  
  
  
  def deleteable?
    self.products.empty?
  end


end
