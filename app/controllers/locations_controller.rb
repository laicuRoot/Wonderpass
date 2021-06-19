class LocationsController < ApplicationController
before_action :find_stampbook

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    @location.user = @stampbook.user
    add_geocoding
    @location.add_stamp_photo
    if @location.save
      @location.generate_stamp(@stampbook)
      redirect_to new_stampbook_location_path(@stampbook)
      flash[:notice] = "#{@location.location_name} was created, please create another location or click finish to exit"
    else
      render :new
    end
  end

  private

  def location_params
    params.require(:location).permit(:location_name, :latitude, :longitude, :location_description, :category, :location_photos)
  end

  def find_stampbook
    @stampbook = Stampbook.find(params[:stampbook_id])
  end

  def add_geocoding
    @location.latitude = Geocoder.search(@location.location_name)[0].data['lat']
    @location.longitude = Geocoder.search(@location.location_name)[0].data['lon']
  end
end
