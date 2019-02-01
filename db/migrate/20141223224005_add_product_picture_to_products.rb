class AddProductPictureToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :product_picture, :string
  end
end
