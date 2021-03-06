class CreatePosts < ActiveRecord::Migration[5.0]
  def self.up
    create_table :posts do |t|
      t.string :title, :null => false, :limit => 100
      t.text :content, :null => false
      t.integer :company_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
