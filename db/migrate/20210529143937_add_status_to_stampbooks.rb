class AddStatusToStampbooks < ActiveRecord::Migration[6.0]
  def change
    add_column :stampbooks, :status, :boolean, default: false
  end
end
