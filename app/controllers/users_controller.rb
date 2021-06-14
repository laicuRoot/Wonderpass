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
      # raise
    @stamp_count = @user.stamps.where(stamp_status: true).count
    @user_active_itinerary = Itinerary.where(active_itinerary: true).where(user: current_user)
    @stamps = @user_active_itinerary.empty? ? @user.stamps : @user_active_itinerary.map(&:stamps).flatten
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
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :username, :photo)
  end
end
