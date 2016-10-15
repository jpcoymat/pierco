class RenameProductPhotoColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :product_photos, :product_photo, :product_photograph
  end
end
