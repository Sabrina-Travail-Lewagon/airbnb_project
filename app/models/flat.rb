class Flat < ApplicationRecord
  belongs_to :equipment
  belongs_to :category
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
end
