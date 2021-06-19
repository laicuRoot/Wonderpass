require 'open-uri'

class Location < ApplicationRecord
  belongs_to :user
  has_many :stamps, dependent: :destroy
  has_many :itinerary_items, through: :stamps
  has_many :stamobooks, through: :stamps
  geocoded_by :location_name
  validates :location_name, :location_description, :latitude, :longitude, :category, presence: true
  validates :location_name, uniqueness: { scope: [:latitude, :longitude] }
  validates :location_name, length: { maximum: 50 }
  validates :location_description, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed" }
  validates :category, inclusion: { in: %w(Natural Historical Cultural Culinary Sports) }
  after_validation :geocode, if: :will_save_change_to_location_name?
  after_create :geocode, if: :will_save_change_to_location_name?
  # after_create :add_stamp_photo
  has_many_attached :location_photos
  has_many_attached :stamp_photos

  def self.get_categories
    Location.all.map{|location| location.category}.uniq
  end

  def find_stamp(location)
    @stamps.find_by(location: location.id)
  end

  def add_stamp_photo
    stamp_url = {
      "Culinary" => "http://res.cloudinary.com/laicuroot/image/upload/v1623269729/v4hwladdia8itca44jqh.png",
      "Sports" => "http://res.cloudinary.com/laicuroot/image/upload/v1623269793/n8epjjjfaftulhgcn20k.png",
      "Historical" => "http://res.cloudinary.com/laicuroot/image/upload/v1623269836/opcwnrbhljb1wl32saub.png",
      "Cultural" => "http://res.cloudinary.com/laicuroot/image/upload/v1623269861/ds36ac9c074gmvldnc8b.png",
      "Natural" => "http://res.cloudinary.com/laicuroot/image/upload/v1623269890/g65zo5fk6ijnrw4s2byb.png"
    }
    stamp_pic = URI.open(stamp_url[self.category])
    self.stamp_photos.attach(io: stamp_pic, filename: "stamp_pic-#{self.location_name}.png", content_type: "image/png")
  end

  def generate_stamp(stampbook)
    stamp = Stamp.new(location: self, stampbook: stampbook)
    stamp.save!
  end
end
