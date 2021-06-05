class ItineraryItemsController < ApplicationController
  before_action :find_itinerary, except: :destroy
  
  def index
    @itinerary_item = ItineraryItem.new
    @locations = Location.near(@itinerary.destination, 20)
    @stamps = @itinerary.user.stamps
  end

  def new
    @itinerary_item = ItineraryItem.new
  end

  def create
    @itinerary_item = ItineraryItem.new(itinerary_item_params)
    @itinerary_item.itinerary = @itinerary
    if @itinerary_item.save
      redirect_to itinerary_itinerary_items_path(@itinerary)
    else
      flash[:alert] = "The itinerary item was not created"
    end
  end

  def destroy
    @itinerary_item = ItineraryItem.find(params[:id])
    @itinerary = @itinerary_item.itinerary
    if @itinerary_item.destroy
      redirect_to itinerary_itinerary_items_path(@itinerary)
    else
      flash[:alert] = "The itinerary item was not destroyed"
    end
  end

  private

  def find_itinerary
    @itinerary = Itinerary.find(params[:itinerary_id])
  end

  def itinerary_item_params
    params.require(:itinerary_item).permit(:stamp_id)
  end
end
