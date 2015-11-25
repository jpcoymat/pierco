class AddHomepageText < ActiveRecord::Migration
  def change
    add_column :companies, :homepage_intro, :text
  end

end
