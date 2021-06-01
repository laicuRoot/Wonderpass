class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  def show
    @stamps = @user.stamps
    @stamp_count = @stamps.where(stamp_status: true).count
    @locations = Location.all
    @markers = @locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        stamp_window: render_to_string(partial: "stamp_window", locals: { stamp: @stamps.find_by(location: location) }),
        image_url: helpers.asset_url("http://res.cloudinary.com/laicuroot/image/upload/c_fill,h_40,w_40/"+ location.stamp_photos.first.key)
      }
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
