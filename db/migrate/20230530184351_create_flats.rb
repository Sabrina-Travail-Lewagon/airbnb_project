class CreateFlats < ActiveRecord::Migration[7.0]
  def change
    create_table :flats do |t|
      t.string :title
      t.text :description
      t.integer :guest_nb
      t.integer :price
      t.string :address
      t.integer :longitude
      t.integer :latitude
      t.references :equipment, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
