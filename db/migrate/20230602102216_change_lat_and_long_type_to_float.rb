class ChangeLatAndLongTypeToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :flats, :longitude, :float
    change_column :flats, :latitude, :float
  end
end
