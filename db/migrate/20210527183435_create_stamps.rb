class CreateStamps < ActiveRecord::Migration[6.0]
  def change
    create_table :stamps do |t|
      t.references :stampbook, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.boolean :stamp_status, default: false

      t.timestamps
    end
  end
end
