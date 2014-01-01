class AddProductAttributeColumns < ActiveRecord::Migration

  def self.up
    add_column  :product_attributes, :diameter,         :decimal, :precision => 9, :scale => 2
    add_column  :product_attributes, :width,            :decimal, :precision => 9, :scale => 2
    add_column  :product_attributes, :maximum_pressure, :decimal, :precision => 9, :scale => 2
    add_column  :product_attributes, :maximum_weight,   :decimal, :precision => 9, :scale => 2
  end

  def self.down
  end
end
