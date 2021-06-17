class ItinerariesController < ApplicationController
  before_action :find_user, except: [:filter, :destroy, :activate, :show]

  def index
    # @stamps_all = Stamp.all.where(user: @stampbooks..user)
    # @locations = Location.all
    @itineraries = Itinerary.where(user: @user)
    @user_active_itinerary = Itinerary.get_active(@user)
    @stamps = @user_active_itinerary.map(&:stamps).flatten
    @stamps_all = Stamp.all.where(id: @stamps)
    @all_int_stamps = @itineraries.map(&:stamps).flatten
    # @stamps = @itineraries.map{ |itinerary| itinerary.stamps }.flatten
    @locations = Location.where(id: @stamps.map(&:location_id))
    @itinerary_markers = @locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        stampWindow: render_to_string(partial: "stamp_itinerary_window", locals: { stamp: @stamps_all.find_by(location: location) }),
        imageUrl: helpers.asset_url("http://res.cloudinary.com/laicuroot/image/upload/c_fill,h_40,w_40/"+ location.stamp_photos.first.key),
        stampStatus: @stamps_all.find_by(location: location).stamp_status
      }
    end
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    @collected = @itinerary.collected_stamps
    @total = @itinerary.itinerary_items.count
    @stamps = @itinerary.stamps
    @locations = Location.where(id: @stamps.map(&:location_id))
    @markers = @locations.geocoded.map do |stamp|
      {
        lat: stamp.latitude,
        lng: stamp.longitude,
        stampWindow: render_to_string(partial: "users/stamp_window", locals: { stamp: @stamps.find_by(location: stamp)}),
        imageUrl: helpers.asset_url("http://res.cloudinary.com/laicuroot/image/upload/c_fill,h_40,w_40/"+ stamp.stamp_photos.first.key),
        stampStatus: @stamps.find_by(location: stamp).stamp_status
      }
    end
  end

  def filter
    @itinerary = Itinerary.find(params[:id])
    @categories = Location.get_categories
    @distances = Itinerary.get_distances
  end

  def new
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)
    @itinerary.rating = 0
    @itinerary.user = @user
    if @itinerary.save
      redirect_to filter_itinerary_path(@itinerary)
    else
      render :new
    end
  end

  def destroy
    @itinerary = Itinerary.find(params[:id])
    @user = @itinerary.user
    if @itinerary.destroy
      redirect_to user_itineraries_path(@user)
    end
  end

  def activate
    @itinerary = Itinerary.find(params[:itinerary_id])
    @itinerary.active_itinerary = true
    if @itinerary.save
      Itinerary.set_inactive(@itinerary)
      redirect_to user_itineraries_path(current_user)
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
