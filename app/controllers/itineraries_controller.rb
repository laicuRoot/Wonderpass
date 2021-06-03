class ItinerariesController < ApplicationController
  before_action :find_user, except: [:show]

  def index
    @itineraries = Itinerary.where(user: @user)
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    @itinerary.itinerary_items.create(id: 1, itinerary_id: 1, stamp_id: 1)
    @itinerary.itinerary_items.create(id: 2, itinerary_id: 1, stamp_id: 2)
    @markers = Location.all.geocoded.map do |stamp|
      {
        lat: stamp.latitude,
        lng: stamp.longitude
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
