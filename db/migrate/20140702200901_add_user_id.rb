class AddUserId < ActiveRecord::Migration
  def change
    add_column :change_logs, :user_id, :integer

  end
end
