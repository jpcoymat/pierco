class AddDescriptionToProduct < ActiveRecord::Migration[5.0]

  def self.up
	add_column :products, :description, :text
  end

  def self.down
  end
end
