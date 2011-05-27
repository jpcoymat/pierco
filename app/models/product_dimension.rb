class ProductDimension < ActiveRecord::Base

  validates :product_id, :name, :presence => true
  validates_uniqueness_of :name, :scope => :product_id
  
  def self.attribute_dictionary
    @@attribute_dictionary = {"maximum_pressure" => "Presion Maxima",
                              "maximum_weight" => "Peso Maximo",
                              "length" => "Largo",
                              "width" => "Ancho",
                              "color" => "Color" }
  end
  
  def self.dimension_attributes
    @@dimension_attributes = []
    ProductDimension.columns.each {|column| @@dimension_attributes << column.name }
    @@dimension_attributes.delete("id")
    @@dimension_attributes.delete("product_id")
    @@dimension_attributes.delete("name")
    @@dimension_attributes.delete("created_at")
    @@dimension_attributes.delete("updated_at")
    @@dimension_attributes
  end

  

end
