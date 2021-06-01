class ItineraryItemsController < ApplicationController
  def new
    @stamps = Stamp.near(@location, @distance)
  end

  def create
  end

  def destroy
  end
end
