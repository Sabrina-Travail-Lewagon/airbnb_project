class Booking < ApplicationRecord
  belongs_to :flat
  belongs_to :customer, class_name: "User", foreign_key: "user_id"
  validates :date_arrival, :date_departure, presence: true
  validates :date_departure, comparison: { greater_than: :date_arrival }
  # Status ne peut prendre que les valeurs : Cancelled, Pendinf et Approuved
  validates :status, inclusion: { in: ['Cancelled', 'Pending', 'Approved']}
end
