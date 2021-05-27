class CreateItineraries < ActiveRecord::Migration[6.0]
  def change
    create_table :itineraries do |t|
      t.references :user, null: false, foreign_key: true
      t.float :rating
      t.boolean :public_status, default: false

      t.timestamps
    end
  end
end
