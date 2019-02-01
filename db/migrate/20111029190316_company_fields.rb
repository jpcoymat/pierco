class CompanyFields < ActiveRecord::Migration[5.0]
  def self.up
    add_column :companies, :slogan, :string, :limit => 150
    add_column :companies, :about_us_side_1, :text
    add_column :companies, :about_us_side_2, :text
    add_column :companies, :about_us_side_3, :text
    rename_column :companies, :about_us, :about_us_main
  end

  def self.down
  end
end
