class ItinerariesController < ApplicationController
  before_action :find_user, except: [:show, :filter, :destroy, :activate]

def index
  # @stamps_all = Stamp.all.where(user: @stampbooks..user)
  @locations = Location.all
  @itineraries = Itinerary.where(user: @user)
  @active_itinerary = Itinerary.where(active_itinerary: true)
  @stamps = @active_itinerary.map(&:stamps).flatten
  @stamps_all = Stamp.all.where(id: @stamps)
  # @stamps = @itineraries.map(&:stamps).flatten
  # @stamps = @itineraries.map{ |itinerary| itinerary.stamps }.flatten
  @locations = Location.where(id: @stamps.map(&:location_id))
  @itinerary_markers = @locations.geocoded.map do |location|
    {
      lat: location.latitude,
      lng: location.longitude,
      stamp_window: render_to_string(partial: "stamp_itinerary_window", locals: { stamp: @stamps_all.find_by(location: location) }),
      image_url: helpers.asset_url("http://res.cloudinary.com/laicuroot/image/upload/c_fill,h_40,w_40/"+ location.stamp_photos.first.key)
    }
  end
end

  def show
    @itinerary = Itinerary.find(params[:id])
    @stamps = @itinerary.stamps
    @locations = Location.where(id: @stamps.map(&:location_id))
    @markers = @locations.geocoded.map do |stamp|
      {
        lat: stamp.latitude,
        lng: stamp.longitude,
        stamp_window: render_to_string(partial: "users/stamp_window", locals: { stamp: @stamps.find_by(location: stamp)}),
        image_url: helpers.asset_url("http://res.cloudinary.com/laicuroot/image/upload/c_fill,h_40,w_40/"+ stamp.stamp_photos.first.key)
      }
    end
  end

  def filter
    @itinerary = Itinerary.find(params[:id])
    @categories = Location.all.map{|location| location.category}.uniq
    @distances = [0, 5, 10, 20, 50, "Other"]
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
      redirect_to new_user_itinerary_path(@user)
    end
  end

  def activate
    @itinerary = Itinerary.find(params[:itinerary_id])
    @itinerary.active_itinerary = true
    @itinerary.save
    redirect_to user_itineraries_path(current_user)
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def itinerary_params
    params.require(:itinerary).permit(:itinerary_name, :destination, :public_status)
  end
end
