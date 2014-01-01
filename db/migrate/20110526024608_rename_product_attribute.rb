class RenameProductAttribute < ActiveRecord::Migration

  def self.up
    rename_column :product_attributes, :product_attribute_1, :product_attribute
    remove_column :product_attributes, :product_attribute_2
    remove_column :product_attributes, :product_attribute_3
    remove_column :product_attributes, :product_attribute_4
    remove_column :product_attributes, :product_attribute_5
    
  end

  def self.down
  end
end
