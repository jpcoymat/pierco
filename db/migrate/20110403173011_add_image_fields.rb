class AddImageFields < ActiveRecord::Migration

  def self.up
    add_column  :suppliers, :logo_filename,   :string, :limit => 50  
  end

  def self.down
  end
end
