class ItinerariesController < ApplicationController
  before_action :find_user, except: [:show]

  def index
    @stamps = Stamp.all
    @locations = Location.all
    @itineraries = Itinerary.where(user: @user)
    @itinerary_items = ItineraryItem.where(itinerary_id: @itineraries.ids)
    @itinerary_items_stamps = Stamp.where(id: @itinerary_items)
    @get_location = Location.where(id: @itinerary_items_stamps)
    # @itinerary_locations = Location.where(id: @itinerary_items_stamps.where(location_id: @locations.ids))
    @itinerary_markers = @get_location.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude
        # stamp_window: render_to_string(partial: "stamp_window", locals: { stamp: @stamps.find_by(location: location) })
        # image_url: helpers.asset_url("http://res.cloudinary.com/laicuroot/image/upload/c_fill,h_40,w_40/"+ location.stamp_photos.first.key)
      }
    end
  end

  def show
    @itinerary = Itinerary.find(params[:id])
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
