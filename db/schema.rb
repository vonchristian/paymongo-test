# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_18_081632) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "entry_points", force: :cascade do |t|
    t.string "name"
    t.bigint "parking_lot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "parking_lot_id"], name: "index_entry_points_on_name_and_parking_lot_id", unique: true
    t.index ["parking_lot_id"], name: "index_entry_points_on_parking_lot_id"
  end

  create_table "parking_lots", force: :cascade do |t|
    t.string "name", null: false
    t.string "location", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parking_rates", force: :cascade do |t|
    t.bigint "slot_type_id", null: false
    t.bigint "base_rate_cents", null: false
    t.bigint "hourly_rate_cents", null: false
    t.bigint "daily_rate_cents", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slot_type_id"], name: "index_parking_rates_on_slot_type_id"
  end

  create_table "parking_slots", force: :cascade do |t|
    t.bigint "parking_lot_id", null: false
    t.bigint "slot_type_id", null: false
    t.jsonb "distances"
    t.boolean "occupied", default: false
    t.bigint "entry_point_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entry_point_id"], name: "index_parking_slots_on_entry_point_id"
    t.index ["occupied"], name: "index_parking_slots_on_occupied"
    t.index ["parking_lot_id"], name: "index_parking_slots_on_parking_lot_id"
    t.index ["slot_type_id"], name: "index_parking_slots_on_slot_type_id"
  end

  create_table "slot_types", force: :cascade do |t|
    t.bigint "parking_lot_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "parking_lot_id"], name: "index_slot_types_on_name_and_parking_lot_id", unique: true
    t.index ["parking_lot_id"], name: "index_slot_types_on_parking_lot_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "plate_number", null: false
    t.string "vehicle_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plate_number"], name: "index_vehicles_on_plate_number", unique: true
  end

  add_foreign_key "entry_points", "parking_lots"
  add_foreign_key "parking_rates", "slot_types"
  add_foreign_key "parking_slots", "entry_points"
  add_foreign_key "parking_slots", "parking_lots"
  add_foreign_key "parking_slots", "slot_types"
  add_foreign_key "slot_types", "parking_lots"
end
