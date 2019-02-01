class RenameFilenames < ActiveRecord::Migration[5.0]

  def self.up
    rename_column :companies, :logo_filename, :image_filename
    rename_column :suppliers, :logo_filename, :image_filename
  end

  def self.down
  end
end
