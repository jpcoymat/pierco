class AddLogoFilenamToCompany < ActiveRecord::Migration

  def self.up
    add_column :companies, :logo_filename, :string, :limit => 100
  end

  def self.down
  end
end
