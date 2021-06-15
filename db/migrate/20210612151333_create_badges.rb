class CreateBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :badges do |t|
      t.integer :value
      t.string :name
      t.text :description
      t.string :color
      t.string :image_url

      t.timestamps
    end
  end
end
