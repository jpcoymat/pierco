class RenameProductAttributeColumns < ActiveRecord::Migration

  def self.up
	rename_column :product_attributes, :attribute_1, :product_attribute_1
	rename_column :product_attributes, :attribute_2, :product_attribute_2
	rename_column :product_attributes, :attribute_3, :product_attribute_3
	rename_column :product_attributes, :attribute_4, :product_attribute_4
	rename_column :product_attributes, :attribute_5, :product_attribute_5
  end

  def self.down
  end
end
