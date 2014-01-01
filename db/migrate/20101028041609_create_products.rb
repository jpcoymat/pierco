class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.integer :supplier_id, :null => false
      t.string :name, :null => false, :limit => 50, :unique=> true
      t.boolean :active, :null => false, :default => true
      t.string :attribute_1
      t.string :attribute_2
      t.string :attribute_3
      t.string :attribute_4
      t.string :attribute_5

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
