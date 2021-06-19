class UsersController < ApplicationController
  before_action :find_user

  def show
    @stamp_count = @user.collected_stamps.size
    @user_active_itinerary = Itinerary.get_active(@user)
    @ranking_number = 1
    @badges = Badge.all
    @num_bronze_stars = @user.achievements.map(&:badge_id).count(@badges[2].id)
    @num_silver_stars = @user.achievements.map(&:badge_id).count(@badges[1].id)
    @num_gold_stars = @user.achievements.map(&:badge_id).count(@badges[0].id)
    get_invitations
    get_search
    get_stamps
    get_locations
    get_active_markers
    get_all_markers
  end

  def edit
    if (@user != current_user)
      redirect_to edit_user_path(current_user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "User profile updated"
    end
  end

  private

  def get_search
    @query = params[:query]
    if @query.present?
      @users = User.search_by_username_and_fullname(params[:query])
    end
    respond_to do |format|
      format.html
      format.text
    end
  end

  def get_invitations
    @invitation = Invitation.new
    @friends_received = Invitation.all.where(user_id: current_user, confirmed: true)
    @friends_sent = Invitation.all.where(friend_id: current_user, confirmed: true)
    @friends = @friends_sent + @friends_received
    @received = Invitation.where(friend_id: current_user, confirmed: false)
    @sent = Invitation.where(user_id: current_user, confirmed: false)
    @user_invitation = Invitation.where(user_id: current_user, friend_id: @user )
    @friend_invitation = Invitation.where(friend_id: current_user, user_id: @user)
    @all_sent = @sent + @received + @friends_sent
    @all_received = @received + @friends_received
  end

  def get_stamps
    @user_stamps = @user.stamps
    @stamps = @user_active_itinerary.map(&:stamps).flatten
    @active_stamps = Stamp.all.where(id: @stamps)
    @all_stamps = Stamp.all.where(id: @user_stamps)
  end

  def get_locations
    @locations = Location.where(id: @stamps.map(&:location_id))
    @all_locations = Location.where(id: @user.stamps.map(&:location_id))
  end

  def get_active_markers
    @markers = @locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        stampStatus: @active_stamps.find_by(location: location).stamp_status,
        stampWindow: render_to_string(partial: "stamp_window", locals: { stamp: @active_stamps.find_by(location: location) }),
        imageUrl: helpers.asset_url("http://res.cloudinary.com/laicuroot/image/upload/c_fill,h_40,w_40/" +
          location.stamp_photos.first.key)
      }
    end
  end

  def get_all_markers
    @second_markers = @all_locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        stampStatus: @all_stamps.find_by(location: location).stamp_status,
        stampWindow: render_to_string(partial: "stamp_window", locals: { stamp: @all_stamps.find_by(location: location) }),
        imageUrl: helpers.asset_url("http://res.cloudinary.com/laicuroot/image/upload/c_fill,h_40,w_40/" +
          location.stamp_photos.first.key)
      }
    end
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :username, :photo)
  end

  def find_active
    @user.itineraries.where(active_itinerary: true).first.itinerary_name
  end
end
