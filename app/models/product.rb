class Product < ApplicationRecord

  mount_uploader :product_picture, ProductPictureUploader 

  validates :name,  :supplier_id, :product_category_id, presence: {message: "Nombre, Marca, y Categoria son obligatorios"}
  validates :name,  uniqueness: {message: "Nombre ya existe"}  
  
  belongs_to  :supplier
  belongs_to  :product_category
  belongs_to  :product_subcategory, optional: true
  has_many    :product_dimensions, dependent: :destroy
  has_many    :product_photos, dependent: :destroy


  def supplier_name
    self.supplier.try(:name)
  end
  
  def supplier_name=(supplier_name)
    self.supplier_id = Supplier.where(name: supplier_name).first.try(:id)
  end

  def product_category_name
    self.product_category.try(:name)
  end
  
  def product_category_name=(category_name)
    self.product_category_id = ProductCategory.where(name: category_name).first.try(:id)
  end

  def product_subcategory_name
    self.product_subcategory.try(:id)
  end
  
  def product_subcategory_name=(subcategory_name)
    self.product_subcategory_id = ProductSubcategory.where(name: subcategory_name).first.try(:id)
  end
  
end
