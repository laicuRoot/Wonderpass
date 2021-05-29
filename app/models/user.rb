class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :stampbooks
  has_many :itineraries
  has_many :stamps, through: :stampbooks

  validates :first_name, :last_name, :username, presence: true
end
