class AddNewCompanyFields < ActiveRecord::Migration

  def self.up
	add_column :companies, :telephone_1, 	:string, 	:limit => 20
	add_column :companies, :telephone_2, 	:string, 	:limit => 20
	add_column :companies, :telephone_3, 	:string, 	:limit => 20
	add_column :companies, :telephone_4, 	:string, 	:limit => 20
	add_column :companies, :telephone_5, 	:string, 	:limit => 20
	add_column :companies, :fax, 		:string, 	:limit => 20
	add_column :companies, :email, 		:string, 	:limit => 50
  end

  def self.down
  end
end
