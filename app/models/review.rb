class Review < ApplicationRecord
  belongs_to :flat
  belongs_to :user
  validates :comment, :rating, presence: true
end
