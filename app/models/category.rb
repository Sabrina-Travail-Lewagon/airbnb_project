class Category < ApplicationRecord
  has_many :flats
  belongs_to :owner, class_name: "User", foreign_key: "user_id"

end
