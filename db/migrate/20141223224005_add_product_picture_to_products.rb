class AddProductPictureToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_picture, :string
  end
end
