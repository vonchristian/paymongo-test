class CreateVehicles < ActiveRecord::Migration[8.0]
  def change
    create_table :vehicles do |t|
      t.string :plate_number, null: false
      t.string :vehicle_type, null: false

      t.timestamps
    end
    add_index :vehicles, :plate_number, unique: true
  end
end
