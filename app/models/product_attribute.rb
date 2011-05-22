class ProductAttribute < ActiveRecord::Base

  belongs_to :product
  validates :product_id, :presence => true
  
  before_create :validate_attributes
  
  def product_attributes
    @product_attributes = self.attributes.clone
    @product_attributes.delete_if {|k,v| !(k.include?("product_attribute_"))}
    @product_attributes
  end
  
  def validate_attributes
    attributes_validated = false
    index = 1
    while attributes_validated == false
      key = "product_attribute_" + index.to_s
      attributes_validated = true if !(@product_attributes[nonvalid_attribute].blank?)
    end
    attributes_validated 
  end

end
