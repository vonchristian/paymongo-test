class CreateEntryPoints < ActiveRecord::Migration[8.0]
  def change
    create_table :entry_points do |t|
      t.string :name
      t.references :parking_lot, null: false, foreign_key: true

      t.timestamps
    end

    add_index :entry_points, [ :name, :parking_lot_id ], unique: true
  end
end
