class Favorite < ApplicationRecord
  belongs_to :flat
  belongs_to :user
end
