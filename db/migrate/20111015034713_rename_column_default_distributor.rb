class RenameColumnDefaultDistributor < ActiveRecord::Migration
  def self.up
    rename_column :companies, :default_distributor, :default_distributor_id
  end

  def self.down
  end
end
