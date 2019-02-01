class AddHomepageText < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :homepage_intro, :text
  end

end
