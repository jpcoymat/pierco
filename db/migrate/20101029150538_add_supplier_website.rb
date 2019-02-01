class AddSupplierWebsite < ActiveRecord::Migration[5.0]

  def self.up
    add_column :suppliers,:website, :string, :limit=>100
  end

  def self.down
  end
end
