class ResetProductAttribute < ActiveRecord::Migration

  def self.up
    remove_column :product_attributes,  :product_attribute
    add_column    :product_attributes,  :product_attribute, :string,  :null => false, :limit => 20
  end

  def self.down
  end
end
