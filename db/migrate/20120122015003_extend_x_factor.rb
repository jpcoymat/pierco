class ExtendXFactor < ActiveRecord::Migration
  def up
    change_column :product_dimensions, :x_factor, :string, limit: 50
  end

  def down
  end
end
