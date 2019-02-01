class RenameColumnDefaultDistributor < ActiveRecord::Migration[5.0]
  def self.up
    rename_column :companies, :default_distributor, :default_distributor_id
  end

  def self.down
  end
end
