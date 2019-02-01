class RenameAboutUsFields < ActiveRecord::Migration[5.0]

  def self.up
    rename_column :companies, :about_us_side_1, :headline_1_content
    rename_column :companies, :about_us_side_2, :headline_2_content
    rename_column :companies, :about_us_side_3, :headline_3_content
    add_column :companies, :headline_1_title, :string, :limit => 50
    add_column :companies, :headline_2_title, :string, :limit => 50
    add_column :companies, :headline_3_title, :string, :limit => 50
    
  end

  def self.down
  end
end
