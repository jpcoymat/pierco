class ProductSubcategory < ActiveRecord::Base

  belongs_to :product_category
  has_many   :products
  
  validates :product_category_id, :name, :description, presence: true
  validates_uniqueness_of :name, scope: :product_category_id
  
  
  
  def deleteable?
    self.products.empty?
  end
  
  def product_category_name
    self.product_category.try(:name)
  end

  def product_category_name=(category_name)
    self.product_category_id = ProductCategory.where(name: category_name).first.try(:id)
  end

end
