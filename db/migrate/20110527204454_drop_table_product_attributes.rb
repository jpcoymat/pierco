class DropTableProductAttributes < ActiveRecord::Migration

  def self.up
    drop_table :product_attributes
  end

  def self.down
  end
end
