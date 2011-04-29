class CreateDistributors < ActiveRecord::Migration
  def self.up
    create_table :distributors do |t|
      t.integer :company_id,  :null => false
      t.string  :name,        :null => false,   :limit => 100
      t.string  :address_1,   :null => false,   :limit => 100
      t.string  :address_2,                     :limit => 100
      t.string  :city,        :null => false,   :limit => 100
      t.string  :state,                         :limit => 100
      t.string  :postal_code,                   :limit => 10
      t.string  :country,     :null => false,   :limit => 50
      t.timestamps
    end
  end

  def self.down
    drop_table :distributors
  end
end
