class CreateStampbooks < ActiveRecord::Migration[6.0]
  def change
    create_table :stampbooks do |t|
      t.string :stampbook_name
      t.text :stampbook_description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
