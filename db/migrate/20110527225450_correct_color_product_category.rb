class CorrectColorProductCategory < ActiveRecord::Migration

  def self.up
    remove_column :product_categories,  :color
    add_column    :product_categories,  :color, :boolean, :default => false
  end

  def self.down
  end
end
