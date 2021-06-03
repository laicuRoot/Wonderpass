class AddItineraryNameToItineraries < ActiveRecord::Migration[6.0]
  def change
    add_column :itineraries, :itinerary_name, :string
    add_column :itineraries, :destination, :string
  end
end
