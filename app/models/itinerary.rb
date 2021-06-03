class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :itinerary_items
  # validates :rating, numericality: true
  validates :rating, inclusion: { in: [1..5] }
  validates :public_status, inclusion: { in: [true, false] }
  validates :public_status, presence: true
end
