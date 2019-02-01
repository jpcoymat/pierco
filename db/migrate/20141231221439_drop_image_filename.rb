class DropImageFilename < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :image_filename
    remove_column :suppliers, :image_filename
    remove_column :companies, :image_filename
    add_column :suppliers, :supplier_picture, :string
    add_column :companies, :company_picture, :string
  end
end
