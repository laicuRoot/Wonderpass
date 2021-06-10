class ItineraryItemsController < ApplicationController
  before_action :find_itinerary, except: :destroy
  before_action :get_filter, only: :index

  def index
    @itinerary_item = ItineraryItem.new
    @locations = Location.near(@itinerary.destination, @distance).where(category: @categories)
    @stamps = @completed? @itinerary.user.stamps : @itinerary.user.stamps.where(stamp_status: false)
    @locations.where(stamps: @stamps)
  end

  def new
    @itinerary_item = ItineraryItem.new
  end

  def create
    @itinerary_item = ItineraryItem.new(itinerary_item_params)
    @itinerary_item.itinerary = @itinerary
    if @itinerary_item.save
      redirect_back(fallback_location: itinerary_itinerary_items_path(@itinerary))
    else
      flash[:alert] = "The itinerary item was not created"
    end
  end

  def destroy
    @itinerary_item = ItineraryItem.find(params[:id])
    @itinerary = @itinerary_item.itinerary
    if @itinerary_item.destroy
      redirect_back(fallback_location: itinerary_itinerary_items_path(@itinerary))
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

  def get_filter
    @distance = params[:distance] == "Other" ? params[:query].to_i : params[:distance].to_i
    @categories = params[:categories] ? params[:categories].values : Location.all.map{|location| location.category}.uniq
    if params[:add_completed].to_i != 0
      @completed = true
    end
  end

  def activate
    @itinerary.active_itinerary = true
  end
end
