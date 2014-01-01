class AddLengthToProductAttribute < ActiveRecord::Migration

  def self.up
    add_column :product_attributes, :length, :decimal, :precision => 9, :scale => 2
  end

  def self.down
  end
end
