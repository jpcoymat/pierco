class CreateCompanies < ActiveRecord::Migration[5.0]
  def self.up
    create_table :companies do |t|
      t.string :name, :null => false, :limit => 100, :unique => true
      t.string :address_1, :null => false, :limit => 100
      t.string :address_2
      t.string :city, :null => false, :limit => 100
      t.string :state, :null => false, :limit => 50
      t.string :postal_code, :null => false, :limit => 10
      t.string :country, :null => false, :limit => 100

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
