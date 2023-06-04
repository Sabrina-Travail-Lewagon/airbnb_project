class Flat < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many :flat_equipments
  has_many :flat_categories
  has_many :categories, through: :flat_categories
  has_many :equipments, through: :flat_equipments
  has_many_attached :photos
end
