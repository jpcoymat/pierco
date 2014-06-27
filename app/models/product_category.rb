class ProductCategory < ActiveRecord::Base

  validates :name, :description, :company_id, presence: true
  validates :name, uniqueness: true
  
  belongs_to  :company
  has_many    :products
  has_many    :product_subcategories, order: 'display_priority', dependent: :destroy
  
  def deleteable?
    self.products.empty?
  end
  
  def active_dimension_fields
    @active_dimension_fields = []
    all_dimension_fields = ProductDimension.dimension_attributes
    all_dimension_fields.each do |dimension_field|
      @active_dimension_fields << dimension_field if self.attributes[dimension_field]
    end
    @active_dimension_fields
  end

end
