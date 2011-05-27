class AddColor < ActiveRecord::Migration

  def self.up
    add_column  :product_dimensions,  :color, :string,  :limit => 25
    add_column  :product_categories,  :color, :string,  :limit => 25
  end

  def self.down
  end
end
