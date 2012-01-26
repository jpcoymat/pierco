class Product < ActiveRecord::Base

  include Upload

  validates :name,  :supplier_id, :product_category_id, :product_subcategory_id, :presence => true
  validates :name,  :uniqueness => true
  validates :image_filename, :format => {
    :with	=> %r{\.(gif|jpeg|jpg|png)$}i, :message => 'Imagen debe ser tipo GIF, JPG or PNG.'
  }   
  
  belongs_to  :supplier
  belongs_to  :product_category
  belongs_to  :product_subcategory
  has_many    :product_dimensions, :dependent => :destroy, :order => "name"


end
