class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.boolean :created
      t.boolean :submitted
      t.boolean :prep_start
      t.boolean :prep_complete
      t.boolean :cooking_start
      t.boolean :cooking_complete
      t.boolean :delivery_start
      t.boolean :delivery_complete
      t.integer :rating

      t.timestamps
    end
  end
end
