class AddAboutUsToCompany < ActiveRecord::Migration[5.0]

  def self.up
    add_column :companies, :about_us, :text
  end

  def self.down
  end
end
