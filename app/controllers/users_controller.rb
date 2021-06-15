class UsersController < ApplicationController
  before_action :find_user

  def show
    @invitation = Invitation.new

    @friends_received = Invitation.all.where(user_id: current_user, confirmed: true)
    @friends_sent = Invitation.all.where(friend_id: current_user, confirmed: true)
    @friends = @friends_sent + @friends_received

    @user_invitation = Invitation.find_by(user_id: current_user, friend_id: @user)
    @friend_invitation = Invitation.find_by(user_id: @user, friend_id: current_user)


    @invitations = Invitation.where(friend_id: current_user, confirmed: false)
    if params[:query].present?
      @users = User.search_by_username_and_fullname(params[:query])
    end
    respond_to do |format|
      format.html
      format.text
    end
    @stamp_count = @user.collected_stamps.size
    @user_active_itinerary = Itinerary.get_active(@user)
    @all_stamps = @user.stamps
    @achievements = @user.achievements.size
    @stamps = @user_active_itinerary.empty? ? @all_stamps : @user_active_itinerary.map(&:stamps).flatten
    @stamps_all = Stamp.all.where(id: @stamps)
    @locations = Location.where(id: @stamps.map(&:location_id))
    @markers = @locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        stampStatus: @stamps_all.find_by(location: location).stamp_status,
        stampWindow: render_to_string(partial: "stamp_window", locals: { stamp: @stamps_all.find_by(location: location) }),
        imageUrl: helpers.asset_url("http://res.cloudinary.com/laicuroot/image/upload/c_fill,h_40,w_40/" +
          location.stamp_photos.first.key)
      }
    end
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
