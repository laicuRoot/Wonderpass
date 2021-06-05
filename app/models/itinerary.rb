class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :itinerary_items
  has_many :stamps, through: :itinerary_items
  # validates :rating, numericality: true
  # validates :rating, inclusion: { in: [1..5] }
  # validates :public_status, inclusion: [true, false] 
  # validates :public_status, presence: true
end
