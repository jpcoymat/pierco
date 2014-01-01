class CreateProductCategories < ActiveRecord::Migration
  def self.up
    create_table :product_categories do |t|
      t.integer :company_id, :null => false
      t.string :name, :null => false, :unique => true, :limit => 50
      t.string :description, :null => false, :limit => 100

      t.timestamps
    end
  end

  def self.down
    drop_table :product_categories
  end
end
