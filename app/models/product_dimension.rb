class ProductDimension < ActiveRecord::Base

  belongs_to  :product

  validates :product_id, :name, :presence => true
  validates_uniqueness_of :name, :scope => :product_id
  
  def self.attribute_dictionary
    @@attribute_dictionary = {"maximum_pressure" => "Presion (lbls)",
                              "maximum_weight" => "Peso (lbls)",
                              "length" => "Largo",
                              "width" => "Ancho",
                              "color" => "Color",
                              "diameter" => "Diametro (pulg)", 
                              "part_number" => "Num. Pieza",
                              "service_description" => "Desc. Servicio",
                              "lateral_wall" => "Pared Lateral",
                              "rim_width_range" => "Ancho Rin",
                              "tred_depth" => "Prof. Banda Rdmnto (pulg)"}
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
