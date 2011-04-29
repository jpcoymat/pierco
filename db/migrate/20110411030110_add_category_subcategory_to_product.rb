class AddCategorySubcategoryToProduct < ActiveRecord::Migration

  def self.up
    add_column  :products, :product_category_id, :integer
    add_column  :products, :product_subcategory_id, :integer  
  end

  def self.down
  end
end
