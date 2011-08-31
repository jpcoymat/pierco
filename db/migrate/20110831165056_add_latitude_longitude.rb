class AddLatitudeLongitude < ActiveRecord::Migration
  def self.up
    add_column  :companies, :latitude, :decimal, :precision => 10, :scale => 5
    add_column  :companies, :longitude, :decimal, :precision => 10, :scale => 5
    add_column  :distributors, :latitude, :decimal, :precision => 10, :scale => 5
    add_column  :distributors, :longitude, :decimal, :precision => 10, :scale => 5
    
  end

  def self.down
  end
end
