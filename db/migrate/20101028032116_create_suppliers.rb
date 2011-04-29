class CreateSuppliers < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.string :name, :null => false, :limit => 100, :unique => true
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.integer :company_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :suppliers
  end
end
