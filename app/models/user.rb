class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :stampbooks, dependent: :destroy
  has_many :itineraries, dependent: :destroy
  has_many :stamps, through: :stampbooks
  has_many :invitations
  has_many :pending_invitations, -> {where: confirmed: false}, class_name: 'Invitation', foreign_key: "friend_id"
  # validates :first_name, :last_name, :username, presence: true
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
