class CreateParkingRates < ActiveRecord::Migration[8.0]
  def change
    create_table :parking_rates do |t|
      t.references :slot_type, null: false, foreign_key: true
      t.integer :base_rate_cents, limit: 8, null: false
      t.integer :hourly_rate_cents, limit: 8, null: false
      t.integer :daily_rate_cents, limit: 8, null: false

      t.timestamps
    end
  end
end
