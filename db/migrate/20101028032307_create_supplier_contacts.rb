class CreateSupplierContacts < ActiveRecord::Migration
  def self.up
    create_table :supplier_contacts do |t|
      t.integer :supplier_id, :null => false
      t.string :first_name, :null => false, :limit => 50
      t.string :last_name, :null => false, :limit => 50
      t.string :position
      t.string :telephone
      t.string :cell_phone
      t.string :email
      t.string :fax
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country

      t.timestamps
    end
  end

  def self.down
    drop_table :supplier_contacts
  end
end
