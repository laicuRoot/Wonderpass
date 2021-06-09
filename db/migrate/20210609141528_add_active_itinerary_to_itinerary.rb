class AddActiveItineraryToItinerary < ActiveRecord::Migration[6.0]
  def change
    add_column :itineraries, :active_itinerary, :boolean, default: false
  end
end
