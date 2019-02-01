class AddProductImageFilename < ActiveRecord::Migration[5.0]

  def self.up
    add_column :products, :image_filename, :string, :limit => 50
  end

  def self.down
  end
end
