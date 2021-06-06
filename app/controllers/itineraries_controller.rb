class ItinerariesController < ApplicationController
  before_action :find_user, except: [:show]

  def index
    @itineraries = Itinerary.where(user: @user)
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    @stamps = @itinerary.stamps
    @locations = Location.where(id: @stamps.map(&:location_id))
    @markers = @locations.geocoded.map do |stamp|
      {
        lat: stamp.latitude,
        lng: stamp.longitude
        # stamp_window: render_to_string(partial: "stamp_window", locals: { stamp: @itinerary.stamps.find_by(location: location) }),
        # image_url: helpers.asset_url("http://res.cloudinary.com/laicuroot/image/upload/c_fill,h_40,w_40/"+ location.stamp_photos.first.key)
      }
    end
  end

  def new
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)
    @itinerary.rating = 0
    @itinerary.user = @user
    if @itinerary.save
      redirect_to itinerary_itinerary_items_path(@itinerary)
    else
      render :new
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def itinerary_params
    params.require(:itinerary).permit(:itinerary_name, :destination, :public_status)
  end
end
