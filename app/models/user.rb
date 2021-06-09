class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :stampbooks, dependent: :destroy
  has_many :itineraries, dependent: :destroy
  has_many :stamps, through: :stampbooks
  # validates :first_name, :last_name, :username, presence: true
  after_create :create_stampbook_and_stamps

  private
  def create_stampbook_and_stamps
    @stampbook = Stampbook.new(stampbook_name: "Top Wonders of the UK",
                               stampbook_description: "Collect stamps for the major attractions in the UK")
    @stampbook.user = self
    if @stampbook.save
      generate_stamps
    else
      flash.alert = "Stampbook did not create"
    end
  end

  def generate_stamps
    places = Location.all
    places.each do |place|
      @stamp = Stamp.new(
        location: place,
        stampbook: @stampbook
      )
      @stamp.save!
    end
  end
end
