class AddDefaultDistributor < ActiveRecord::Migration[5.0]
  def self.up
    add_column :companies, :default_distributor, :integer
  end

  def self.down
  end
end
