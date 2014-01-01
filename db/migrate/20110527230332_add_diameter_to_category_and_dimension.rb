class AddDiameterToCategoryAndDimension < ActiveRecord::Migration

  def self.up
    add_column  :product_categories,  :diameter, :boolean, :default => false
    add_column  :product_dimensions,  :diameter,  :decimal, :precision => 10, :scale => 2
  end

  def self.down
  end
end
