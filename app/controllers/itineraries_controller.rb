class ItinerariesController < ApplicationController
  before_action :find_user, except: [:show, :filter]

  def index
    @itineraries = Itinerary.where(user: @user)
  end

  def show
    @itinerary = Itinerary.find(params[:id])
  end

  def filter
    @itinerary = Itinerary.find(params[:id])
    @categories = Location.all.map{|location| location.category}.uniq
    @distances = [0, 5, 10, 20, 50]
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

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def itinerary_params
    params.require(:itinerary).permit(:itinerary_name, :destination, :public_status)
  end
end
