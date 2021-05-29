class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :location_name
      t.float :latitude
      t.float :longitude
      t.text :location_description
      t.string :category

      t.timestamps
    end
  end
end
