class ItineraryItem < ApplicationRecord
  belongs_to :itinerary
  belongs_to :stamp
  validates :stamp_id, uniqueness: { scope: :itinerary_id }
end
