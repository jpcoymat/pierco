class AddDimensionAttributeToCategories < ActiveRecord::Migration

  def self.up
    add_column  :product_categories,  :length,            :boolean, :default => false
    add_column  :product_categories,  :width,             :boolean, :default => false
    add_column  :product_categories,  :maximum_pressure,  :boolean, :default => false
    add_column  :product_categories,  :maximum_weight,    :boolean, :default => false
  end

  def self.down
  end
end
