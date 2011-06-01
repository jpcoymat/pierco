class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.integer :company_id,          :null => false
	    t.string  :name,  :limit => 75, :null => false
	    t.string  :email, :limit => 75, :null => false
	    t.text    :message,             :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
