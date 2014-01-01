class CreateProductDimensions < ActiveRecord::Migration
  def self.up
    create_table :product_dimensions do |t|
      t.integer     :product_id, :nulll => false    
      t.string      :name, :null => false
      t.decimal     :length,  :precision => 10, :scale => 2
      t.decimal     :width,  :precision => 10, :scale => 2
      t.decimal     :maximum_pressure,  :precision => 10, :scale => 2
      t.decimal     :maximum_weight,  :precision => 10, :scale => 2
      
      t.timestamps
    end
  end

  def self.down
    drop_table :product_dimensions
  end
end
