class AddSupplierFields < ActiveRecord::Migration[5.0]

  def self.up
    add_column  :distributors, :telephone_1,  :string,  :limit => 15
    add_column  :distributors, :telephone_2,  :string,  :limit => 15
    add_column  :distributors, :telephone_3,  :string,  :limit => 15
    add_column  :distributors, :email,        :string,  :limit => 50

  end

  def self.down
  end
end
