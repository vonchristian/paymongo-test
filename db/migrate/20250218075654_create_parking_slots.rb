class CreateParkingSlots < ActiveRecord::Migration[8.0]
  def change
    create_table :parking_slots do |t|
      t.references :parking_lot, null: false, foreign_key: true
      t.references :slot_type, null: false, foreign_key: true
      t.jsonb :distances
      t.boolean :occupied, default: false
      t.references :entry_point, null: false, foreign_key: true

      t.timestamps
    end

    add_index :parking_slots, :occupied
  end
end
