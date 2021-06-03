class Stamp < ApplicationRecord
  belongs_to :stampbook
  belongs_to :location
  has_many :itinerary_items
  validates :stampbook_id, uniqueness: { scope: :location_id }
  validates :stamp_status, inclusion: [true, false]
end
