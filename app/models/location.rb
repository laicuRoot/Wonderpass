class Location < ApplicationRecord
  belongs_to :user
  has_many :stamps, dependent: :destroy
  has_many :itinerary_items, through: :stamps
  has_many :stamobooks, through: :stamps
  geocoded_by :location_name
  validates :location_name, :location_description, :category, presence: true
  validates :location_name, uniqueness: { scope: [:latitude, :longitude] }
  validates :location_name, length: { maximum: 50 }
  validates :location_description, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed" }
  validates :category, inclusion: { in: %w(Natural Historical Cultural Culinary Sports) }
  after_validation :geocode, if: :will_save_change_to_location_name?
  has_many_attached :location_photos
  has_many_attached :stamp_photos

  def self.get_categories
    Location.all.map{|location| location.category}.uniq
  end

  def find_stamp(location)
    @stamps.find_by(location: location.id)
  end
end
