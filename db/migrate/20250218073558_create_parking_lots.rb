class CreateParkingLots < ActiveRecord::Migration[8.0]
  def change
    create_table :parking_lots do |t|
      t.string :name, null: false
      t.string :location, null: false

      t.timestamps
    end
  end
end
