class Stampbook < ApplicationRecord
  belongs_to :user
  has_many :stamps, dependent: :destroy
  validates :stampbook_name, :stampbook_description, presence: true
  validates :stampbook_name, length: { maximum: 50 }
  validates :stampbook_description, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed" }
end
