class Category < ApplicationRecord
  has_many :flat_categories
  has_many :flats, through: :flat_categories
end
