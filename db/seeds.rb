# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
parking_lot = ParkingModule::ParkingLot.create!(name: "Parking Lot 1", location: "Main Street")
main_entry_point = ParkingModule::EntryPoint.create!(name: "Main Entrance", parking_lot: parking_lot)
side_entry_point = ParkingModule::EntryPoint.create!(name: "Side Entrance", parking_lot: parking_lot)
back_entry_point = ParkingModule::EntryPoint.create!(name: "Back Entrance", parking_lot: parking_lot)

small_slot_type = ParkingModule::SlotType.create!(name: "small", parking_lot: parking_lot)
medium_slot_type = ParkingModule::SlotType.create!(name: "medium", parking_lot: parking_lot)
large_slot_type = ParkingModule::SlotType.create!(name: "large", parking_lot: parking_lot)

small_rate = ParkingModule::ParkingRate.create!(slot_type: small_slot_type, base_rate: 40, hourly_rate: 20, daily_rate: 5000)
medium_rate = ParkingModule::ParkingRate.create!(slot_type: medium_slot_type, base_rate: 40, hourly_rate: 60, daily_rate: 5000)
large_rate = ParkingModule::ParkingRate.create!(slot_type: large_slot_type, base_rate: 40, hourly_rate: 100, daily_rate: 5000)

small_parking_slot1 = ParkingModule::ParkingSlot.create!(parking_lot: parking_lot, slot_type: small_slot_type, entry_point: main_entry_point, distances: { main_entry_point.id => 1, side_entry_point.id => 6, back_entry_point.id => 11 })
small_parking_slot2 = ParkingModule::ParkingSlot.create!(parking_lot: parking_lot, slot_type: small_slot_type, entry_point: main_entry_point, distances: { main_entry_point.id => 2, side_entry_point.id => 7, back_entry_point.id => 12 })
small_parking_slot3 = ParkingModule::ParkingSlot.create!(parking_lot: parking_lot, slot_type: small_slot_type, entry_point: main_entry_point, distances: { main_entry_point.id => 3, side_entry_point.id => 8, back_entry_point.id => 13 })
small_parking_slot4 = ParkingModule::ParkingSlot.create!(parking_lot: parking_lot, slot_type: small_slot_type, entry_point: main_entry_point, distances: { main_entry_point.id => 4, side_entry_point.id => 9, back_entry_point.id => 14 })
small_parking_slot5 = ParkingModule::ParkingSlot.create!(parking_lot: parking_lot, slot_type: small_slot_type, entry_point: main_entry_point, distances: { main_entry_point.id => 5, side_entry_point.id => 10, back_entry_point.id => 15 })

medium_parking_slot1 = ParkingModule::ParkingSlot.create!(parking_lot: parking_lot, slot_type: medium_slot_type, entry_point: main_entry_point, distances: { side_entry_point.id => 1, main_entry_point.id => 6, back_entry_point.id => 11 })
medium_parking_slot2 = ParkingModule::ParkingSlot.create!(parking_lot: parking_lot, slot_type: medium_slot_type, entry_point: main_entry_point, distances: { side_entry_point.id => 2, main_entry_point.id => 7, back_entry_point.id => 12 })
medium_parking_slot3 = ParkingModule::ParkingSlot.create!(parking_lot: parking_lot, slot_type: medium_slot_type, entry_point: main_entry_point, distances: { side_entry_point.id => 3, main_entry_point.id => 8, back_entry_point.id => 13 })
medium_parking_slot4 = ParkingModule::ParkingSlot.create!(parking_lot: parking_lot, slot_type: medium_slot_type, entry_point: main_entry_point, distances: { side_entry_point.id => 4, main_entry_point.id => 9, back_entry_point.id => 14 })
medium_parking_slot5 = ParkingModule::ParkingSlot.create!(parking_lot: parking_lot, slot_type: medium_slot_type, entry_point: main_entry_point, distances: { side_entry_point.id => 5, main_entry_point.id => 10, back_entry_point.id => 15 })

large_parking_slot1 = ParkingModule::ParkingSlot.create!(parking_lot: parking_lot, slot_type: large_slot_type, entry_point: back_entry_point, distances: { back_entry_point.id => 1, side_entry_point.id => 6, main_entry_point.id => 11 })
large_parking_slot2 = ParkingModule::ParkingSlot.create!(parking_lot: parking_lot, slot_type: large_slot_type, entry_point: back_entry_point, distances: { back_entry_point.id => 2, side_entry_point.id => 7, main_entry_point.id => 12 })
large_parking_slot3 = ParkingModule::ParkingSlot.create!(parking_lot: parking_lot, slot_type: large_slot_type, entry_point: back_entry_point, distances: { back_entry_point.id => 3, side_entry_point.id => 8, main_entry_point.id => 13 })
large_parking_slot4 = ParkingModule::ParkingSlot.create!(parking_lot: parking_lot, slot_type: large_slot_type, entry_point: back_entry_point, distances: { back_entry_point.id => 4, side_entry_point.id => 9, main_entry_point.id => 14 })
large_parking_slot5 = ParkingModule::ParkingSlot.create!(parking_lot: parking_lot, slot_type: large_slot_type, entry_point: back_entry_point, distances: { back_entry_point.id => 5, side_entry_point.id => 10, main_entry_point.id => 15 })

small_vehicle = Vehicle.create!(plate_number: "ABC123", vehicle_type: "small")
medium_vehicle = Vehicle.create!(plate_number: "DEF456", vehicle_type: "medium")
large_vehicle = Vehicle.create!(plate_number: "GHI789", vehicle_type: "large")

small_parking_ticket = small_vehicle.parking_tickets.create!(parking_slot: small_parking_slot1, entry_point: main_entry_point, entry_time: (Time.zone.now - 6.hours - 40.minutes), exit_time: Time.zone.now)
medium_parking_ticket = medium_vehicle.parking_tickets.create!(parking_slot: medium_parking_slot1, entry_point: main_entry_point, entry_time: (Time.zone.now - 24.hours), exit_time: Time.zone.now)
large_parking_ticket = large_vehicle.parking_tickets.create!(parking_slot: large_parking_slot1, entry_point: back_entry_point, entry_time: (Time.zone.now - 3.hours - 30.minutes), exit_time: Time.zone.now)
