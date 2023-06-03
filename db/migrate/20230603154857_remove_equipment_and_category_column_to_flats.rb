class RemoveEquipmentAndCategoryColumnToFlats < ActiveRecord::Migration[7.0]
  def change
    remove_column :flats, :category_id
    remove_column :flats, :equipment_id
  end
end
