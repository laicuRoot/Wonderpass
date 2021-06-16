class Stamp < ApplicationRecord
  belongs_to :stampbook
  belongs_to :location
  has_many :itinerary_items, dependent: :destroy
  validates :stampbook_id, uniqueness: { scope: :location_id }
  validates :stamp_status, inclusion: [true, false]
  has_one_attached :user_stamp_photo

  def update_date
    self.updated_at.strftime("%d %B %Y")
  end
end
