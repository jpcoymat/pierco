class ProductAttribute < ActiveRecord::Base

  belongs_to :product
  validates :product_id, :presence => true
  
  before_create :validate_attributes
  
  def product_attributes
    @product_attributes = self.attributes.clone
    @product_attributes.delete_if {|k,v| !(k.include?("product_attribute_"))}
    @product_attributes
  end
  
  def active_product_attributes
    @active_product_attributes = product_attributes
    @active_product_attributes.delete_if {|k,v| v.blank?}
    @active_product_attributes
  end
  
  def validate_attributes
    active_product_attributes.length > 0
  end

end
