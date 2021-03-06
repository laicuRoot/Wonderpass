class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include PgSearch::Model
  pg_search_scope :search_by_username_and_fullname,
    against: [ :username, :first_name, :last_name ],
    using: {
      tsearch: { prefix: true }
    }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :locations, dependent: :destroy
  has_many :stampbooks, dependent: :destroy
  has_many :itineraries, dependent: :destroy
  has_many :stamps, through: :stampbooks
  has_many :achievements, through: :stampbooks
  has_many :invitations, dependent: :destroy
  has_many :pending_invitations, -> { where confirmed: false }, class_name: 'Invitation', foreign_key: "friend_id", dependent: :destroy
  after_create :create_stampbook_and_stamps

  def friends
    friends_i_sent_invitation = Invitation.where(user_id: id, confirmed: true).pluck(:friend_id)
    friends_i_got_invitation = Invitation.where(friend_id: id, confirmed: true).pluck(:user_id)
    ids = friends_i_sent_invitation + friends_i_got_invitation
    User.where(id: ids)
  end

  def friend_with?(user)
    Invitation.confirmed_record?(id, user.id)
  end

  def send_invitation(user)
    invitations.create(friend_id: user.id)
  end

  def all_confirmed_invites
    invitations.where(confirmed: true)
  end

  def invitation_exists?(user)
    Invitation.find_by(user_id: user, friend_id: self) || Invitation.find_by(user_id: self, friend_id: user)
  end

  def collected_stamps
    self.stamps.where(stamp_status: true)
  end

  def create_date
    self.created_at.strftime("%d %B %Y")
  end

  def self.sort_by_achievements
    all.sort_by{ |e| [e.username, e.get_gold, e.get_silver, e.get_bronze, e.collected_stamps.size] }
  end

  def get_gold
    achievements.map(&:badge_id).count(Badge.all[0].id)
  end

  def get_silver
    achievements.map(&:badge_id).count(Badge.all[1].id)
  end

  def get_bronze
    achievements.map(&:badge_id).count(Badge.all[2].id)
  end

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
    places = Location.all.order(:created_at)
    places[0..39].each do |place|
      @stamp = Stamp.new(
        location: place,
        stampbook: @stampbook
      )
      @stamp.save!
    end
  end
end
