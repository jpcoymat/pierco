class AddDescriptionToProduct < ActiveRecord::Migration

  def self.up
	add_column :products, :description, :text
  end

  def self.down
  end
end
