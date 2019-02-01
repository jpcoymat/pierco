class ExtendAll < ActiveRecord::Migration[5.0]
  def up
  	change_column :product_dimensions, :offset, :string, limit:50
  	change_column :product_dimensions, :pcd, :string, limit:50
  	change_column :product_dimensions, :x_factor, :string, limit:50
  	change_column :product_dimensions, :color, :string, limit:50
    change_column :product_dimensions, :holes, :string, limit:50
  	
  end

  def down
  end
end
