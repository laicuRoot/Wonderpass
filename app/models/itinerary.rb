class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :itinerary_items, dependent: :destroy
  has_many :stamps, through: :itinerary_items
  # validates :rating, numericality: true
  # validates :rating, inclusion: { in: [1..5] }
  validates :public_status, inclusion: [true, false] 
  validates :itinerary_name, :destination, presence: true
  # before_save :set_active

  def self.get_active(user)
    Itinerary.where(active_itinerary: true).where(user: user)
  end

  def self.get_distances
    [5, 10, 25, 50, 100, "Other"]
  end

  def find_item_by_stamp
    self.itinerary_items.find_by(stamp_id: stamp.id)
  end

  def first_location_photo
    self.itinerary_items.first.stamp.location.location_photos.first.key
  end

  def all_stamps
    self.user.stamps
  end

  def grab_stamps
    self.map(&:stamps).flatten
  end

  def all_uncollected_stamps
    self.all_stamps.where(stamp_status: false)
  end

  def collected_stamps
    self.itinerary_items.select {|item| item.stamp.stamp_status==true}.count
  end

  def self.set_inactive(itinerary)
    where.not(id: itinerary.id).where(user: itinerary.user).update_all(active_itinerary: false)
  end
end
