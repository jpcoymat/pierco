class AddMoreAttributesProdCat < ActiveRecord::Migration

  def up
	add_column :product_categories, :offset, :boolean, default: false
	add_column :product_categories, :pcd, :boolean, default: false
   	add_column :product_categories, :holes, :boolean, default: false
	add_column :product_categories, :x_factor, :boolean, default: false
	
	add_column :product_dimensions, :offset, :string, limit: 10
	add_column :product_dimensions, :pcd, :string, limit: 10
  	add_column :product_dimensions, :holes, :string, limit: 10
	add_column :product_dimensions, :x_factor, :string, limit: 10
  end

  def down
  end
end
