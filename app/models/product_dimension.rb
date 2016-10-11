class ProductDimension < ApplicationRecord

  belongs_to  :product

  validates :product_id, :name, presence: true
  validates_uniqueness_of :name, scope: :product_id
  
  def self.attribute_dictionary
    @@attribute_dictionary = {	"maximum_pressure" => "Presion (lbs)",
                              	"maximum_weight" => "Peso (lbs)",
                              	"length" => "Largo (in)",
                              	"width" => "Ancho (in)",
                              	"color" => "Color",
                              	"diameter" => "Diametro (in)", 
                              	"part_number" => "Num. Pieza",
                              	"service_description" => "Desc. Servicio",
                              	"lateral_wall" => "Pared Lateral",
                              	"rim_width_range" => "Ancho Rin",
                              	"tred_depth" => "Prof. Banda Rdmnto (in)",
                              	"name" => "Dimension",
				"offset" => "Offset",
				"pcd" => "PCD",
				"holes" => "Huecos",
				"x_factor" => "X-Factor"}
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

  def self.ordered_attributes
    @@ordered_attributes = ["part_number","name","service_description","lateral_wall","diameter","width","maximum_pressure","maximum_weight","rim_width_range","tred_depth","offset","pcd","holes","x_factor","color"]
  end

  def product_name
    self.product.try(:name)
  end
  
  def product_name=(product_name)
    self.product_id = Product.where(name: product_name).first.try(:id)
  end


end
