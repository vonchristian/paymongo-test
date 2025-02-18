class CreateSlotTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :slot_types do |t|
      t.references :parking_lot, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end

    add_index :slot_types, [ :name, :parking_lot_id ], unique: true
  end
end
