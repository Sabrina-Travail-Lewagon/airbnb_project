class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :flat, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :date_departure
      t.date :date_arrival
      t.integer :traveler_nb
      t.integer :total

      t.timestamps
    end
  end
end
