class ProductDimensionAttributes < ActiveRecord::Migration

  def self.up
    add_column :product_dimensions, :part_number,         :string, :limit => 75
    add_column :product_dimensions, :service_description, :string, :limit => 20
    add_column :product_dimensions, :lateral_wall,        :string, :limit => 20
    add_column :product_dimensions, :rim_width_range,     :string, :limit => 20
    add_column :product_dimensions, :tred_depth,          :string, :limit => 20
    
    add_column :product_categories, :part_number,         :boolean, :default => false
    add_column :product_categories, :service_description, :boolean, :default => false
    add_column :product_categories, :lateral_wall,        :boolean, :default => false
    add_column :product_categories, :rim_width_range,     :boolean, :default => false
    add_column :product_categories, :tred_depth,          :boolean, :default => false
    
    
  end

  def self.down
  end
end
