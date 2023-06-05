class Flat < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many :flat_equipments
  has_many :flat_categories
  has_many :categories, through: :flat_categories
  has_many :equipments, through: :flat_equipments
  has_many :bookings
  has_many_attached :photos

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model


  pg_search_scope :search_by_title_and_address,
                  against: [:title, :address],
                  using: {
                    tsearch: { prefix: true }
                  }
end
