class AddAboutUsToCompany < ActiveRecord::Migration

  def self.up
    add_column :companies, :about_us, :text
  end

  def self.down
  end
end
