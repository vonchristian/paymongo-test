class CreateParkingTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :parking_tickets do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.references :parking_slot, null: false, foreign_key: true
      t.references :entry_point, null: false, foreign_key: true
      t.datetime :entry_time, null: false
      t.datetime :exit_time

      t.timestamps
    end
  end
end
