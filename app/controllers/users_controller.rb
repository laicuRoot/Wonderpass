class UsersController < ApplicationController
  before_action :find_user

  def show
  # @stamps = @user.stamps
    # @stamp_count = @stamps.where(stamp_status: true).count
    @user_active_itinerary = Itinerary.where(active_itinerary: true).where(user: current_user)
    @stamps = @user_active_itinerary.map(&:stamps).flatten
    @stamps_all = Stamp.all.where(id: @stamps)
    @locations = Location.where(id: @stamps.map(&:location_id))
    @markers = @locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        stamp_window: render_to_string(partial: "stamp_window", locals: { stamp: @stamps_all.find_by(location: location) }),
        image_url: helpers.asset_url("http://res.cloudinary.com/laicuroot/image/upload/c_fill,h_40,w_40/" +
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
