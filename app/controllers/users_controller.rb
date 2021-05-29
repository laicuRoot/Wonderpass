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
        infoWindow: render_to_string(partial: "info_window", locals: { stamp: @stamps.where(location: location) })
      }
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
