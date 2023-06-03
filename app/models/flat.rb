class Flat < ApplicationRecord
  belongs_to :equipment
  belongs_to :category
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many :users, through: :reviews
  has_many :users, through: :favorites
  has_many_attached :photos

  include PgSearch::Model

  pg_search_scope :search_by_title_and_address,
                  against: [:title, :address],
                  using: {
                    tsearch: { prefix: true }
                  }
end
