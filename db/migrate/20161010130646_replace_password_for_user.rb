class ReplacePasswordForUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :hashed_password
    add_column :users, :password, :string
  end
end
