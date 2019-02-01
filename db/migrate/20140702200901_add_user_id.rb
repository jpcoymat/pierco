class AddUserId < ActiveRecord::Migration[5.0]
  def change
    add_column :change_logs, :user_id, :integer

  end
end
