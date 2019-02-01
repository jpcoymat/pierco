class CreateUsers < ActiveRecord::Migration[5.0]
  def self.up
    create_table :users do |t|
      t.string :first_name, :null => false, :limit => 50
      t.string :last_name, :null => false, :limit => 50
      t.string :hashed_password, :null => false
      t.string :username, :null => false, :limit => 25
      t.string :email, :limit=> 50
      t.integer :company_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
