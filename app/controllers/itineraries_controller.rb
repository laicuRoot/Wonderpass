class ItinerariesController < ApplicationController
  before_action :find_user, except: [:show]

  def index
    @itineraries = Itinerary.where(user: @user)
  end

  def show 
    @itinerary = Itinerary.find(params[:id])
  end

  def new
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)
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
    params.require(:itinerary).permit(:itinerary_name, :destination, :public_status, rating: 3)
  end
end
