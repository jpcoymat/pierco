class AddDisplayPrioritySubcategory < ActiveRecord::Migration[5.0]

  def up
	add_column :product_subcategories, :display_priority, :integer, :default => 0
  end

  def down
  end
end
