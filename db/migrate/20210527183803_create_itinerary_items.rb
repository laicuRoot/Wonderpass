class CreateItineraryItems < ActiveRecord::Migration[6.0]
  def change
    create_table :itinerary_items do |t|
      t.references :itinerary, null: false, foreign_key: true
      t.references :stamp, null: false, foreign_key: true

      t.timestamps
    end
  end
end
