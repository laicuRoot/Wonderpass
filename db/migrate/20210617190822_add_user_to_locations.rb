class AddUserToLocations < ActiveRecord::Migration[6.0]
  def change
    add_reference :locations, :user, foreign_key: true
  end
end
