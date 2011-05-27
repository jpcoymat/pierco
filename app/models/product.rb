class Product < ActiveRecord::Base

  include Upload

  validates :name,  :supplier_id, :presence => true
  validates :name,  :uniqueness => true
  validates :image_filename, :format => {
    :with	=> %r{\.(gif|jpeg|jpg|png)$}i, :message => 'Imagen debe ser tipo GIF, JPG or PNG.'
  }   
  
  belongs_to  :supplier
  belongs_to  :product_category
  belongs_to  :product_subcategory
  has_many    :product_attributes, :dependent => :destroy

  def active_product_attributes_fields
    @active_product_attributes_fields = []
    ProductAttribute.new.attributes.each do |key,value|
      product_attributes = ProductAttribute.where(:product_id => self.id)
      product_attributes.where("#{key} is not null")
      @active_product_attributes_fields << key unless  product_attributes.all.empty?
    end
    @active_product_attributes_fields.delete("product_attribute")
    @active_product_attributes_fields.delete("id")
    @active_product_attributes_fields.delete("created_at")
    @active_product_attributes_fields.delete("updated_at")
    @active_product_attributes_fields.delete("product_id")
    @active_product_attributes_fields.insert(0,"product_attribute")
    @active_product_attributes_fields
  end

end
