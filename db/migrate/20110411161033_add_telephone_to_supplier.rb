class AddTelephoneToSupplier < ActiveRecord::Migration[5.0]

  def self.up
    add_column  :suppliers, :telephone, :string, :limit => 20
  end

  def self.down
  end
end
