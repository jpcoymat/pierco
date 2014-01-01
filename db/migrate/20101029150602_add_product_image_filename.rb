class AddProductImageFilename < ActiveRecord::Migration

  def self.up
    add_column :products, :image_filename, :string, :limit => 50
  end

  def self.down
  end
end
