class AddTelephoneToSupplier < ActiveRecord::Migration

  def self.up
    add_column  :suppliers, :telephone, :string, :limit => 20
  end

  def self.down
  end
end
