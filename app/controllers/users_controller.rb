class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @stamps = @user.stamps
    @stamp_count = @stamps.where(stamp_status: true).count
    @markers = @stamps.locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude
      }
    end
  end
end
