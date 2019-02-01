class RemoveAttributesFromProducts < ActiveRecord::Migration[5.0]
  def self.up
	remove_column :products, :attribute_1
	remove_column :products, :attribute_2
	remove_column :products, :attribute_3
	remove_column :products, :attribute_4
	remove_column :products, :attribute_5
  end

  def self.down
  end
end
