class AddLengthToOffset < ActiveRecord::Migration
  def change
	change_column :product_dimensions, :offset, :string, limit:20
	change_column :product_dimensions, :pcd, :string, limit:20
	change_column :product_dimensions, :x_factor, :string, limit:20
  end
end
