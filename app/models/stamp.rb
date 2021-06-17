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

  def add_stamp_to_other_stampbooks
    if stamp_status == true
      stampbooks = self.stampbook.user.stampbooks
      stampbooks.each do |stampbook|
        stamp = stampbook.stamps.find_by_location_id(self.location.id)
        stamp.update(stamp_status: true) if stamp
      end
    end
  end

end
