class AddCategorySubcategoryToProduct < ActiveRecord::Migration[5.0]

  def self.up
    add_column  :products, :product_category_id, :integer
    add_column  :products, :product_subcategory_id, :integer  
  end

  def self.down
  end
end
