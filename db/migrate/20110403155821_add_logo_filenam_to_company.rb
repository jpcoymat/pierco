class AddLogoFilenamToCompany < ActiveRecord::Migration[5.0]

  def self.up
    add_column :companies, :logo_filename, :string, :limit => 100
  end

  def self.down
  end
end
