class ExtendXFactor < ActiveRecord::Migration[5.0]
  def up
    change_column :product_dimensions, :x_factor, :string, limit: 50
  end

  def down
  end
end
