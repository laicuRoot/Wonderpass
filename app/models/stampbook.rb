class Stampbook < ApplicationRecord
  belongs_to :user
  has_many :stamps, dependent: :destroy
  has_many :locations, :through => :stamps
  has_many :achievements
  has_many :badges, through: :achievements

  validates :stampbook_name, :stampbook_description, presence: true
  validates :stampbook_name, length: { maximum: 50 }
  validates :stampbook_description, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed" }

  def self.create_stamps(stampbook, newbook)
    stamps = Stampbook.find(stampbook.id).stamps
    stamps.each do |stamp|
      newstamp = Stamp.new(stampbook: newbook, location: stamp.location)
      newstamp.save!
    end
  end

  def none_collected?
    self.stamps.select(&:stamp_status).size.zero?
  end

  def collected_stamps
    self.stamps.where(stamp_status: true)
  end

  def percent_completed
    collected = collected_stamps.size
    total = count_stamps
    (collected.fdiv(total) * 100).floor
  end

  def stampbook_pages
    count_stamps.fdiv(6).ceil
  end

  def count_stamps
    self.stamps.count
  end
end
