class ProductCategory < ActiveRecord::Base

  validates :name, :description, :company_id, :presence => true
  validates :name,                            :uniqueness => true
  
  belongs_to  :company
  has_many    :products
  has_many    :product_subcategories
  
  def deleteable?
    self.products.empty?
  end

end
