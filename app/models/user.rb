class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :flats
  has_many :bookings
  validates :first_name, :last_name, :email, :phone_number, presence: true
  validates :phone_number, uniqueness: true # Téléphone doit être unique
  # On doit avoir qu'un unique prenom et nom combiné
  validates :first_name, uniqueness: { scope: :last_name }
end
