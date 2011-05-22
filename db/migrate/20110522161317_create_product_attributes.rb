class CreateProductAttributes < ActiveRecord::Migration
  def self.up
    create_table :product_attributes do |t|
      t.integer :product_id, 	:null => false
      t.string :attribute_1,	:limit => 10
      t.string :attribute_2,    :limit => 10
      t.string :attribute_3,    :limit => 10
      t.string :attribute_4,    :limit => 10
      t.string :attribute_5,    :limit => 10

      t.timestamps
    end
  end

  def self.down
    drop_table :product_attributes
  end
end
