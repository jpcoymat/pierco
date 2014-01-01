class AddDefaultDistributor < ActiveRecord::Migration
  def self.up
    add_column :companies, :default_distributor, :integer
  end

  def self.down
  end
end
