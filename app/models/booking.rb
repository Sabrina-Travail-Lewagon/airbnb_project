class Booking < ApplicationRecord
  belongs_to :flat
  belongs_to :owner, class_name: "User", foreign_key: "customer_id"
  validates :date_arrival, :date_departure, presence: true
end
